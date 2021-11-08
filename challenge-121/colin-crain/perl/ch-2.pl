#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       door-to-door.pl
#
#       The Travelling Salesman
#         Submitted by: Jorg Sommrey
#         You are given a NxN matrix containing the distances between N cities.
# 
#         Write a script to find a round trip of minimum length visiting all N
#         cities exactly once and returning to the start.
# 
#         Example
#         Matrix: [0, 5, 2, 7]          
#                 [5, 0, 5, 3]          
#                 [3, 1, 0, 6]          
#                 [4, 5, 4, 0]          
# 
#         Output:
#                 length = 10
#                 tour = (0 2 1 3 0)
# 
#         BONUS 1: For a given number N, create a random NxN distance matrix and
#                      find a solution for this matrix.
# 
#         BONUS 2: Find a solution for a random matrix of size 15x15 or 20x20
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use utf8;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';
use Algorithm::Combinatorics qw( permutations );
use List::Util               qw( min first );

# srand(1234567890);

my $mat = [
    [0, 5, 2, 7],
    [5, 0, 5, 3],
    [3, 1, 0, 6],
    [4, 5, 4, 0]
];


## uncomment to produce random asymmetrical matrix

$mat = rand_amat(8);
print_mat( $mat );


say '';

my ($min, $path);

($min, $path) = exact_ts( $mat );
say '';
say 'exact:';
say "\tmin dist $min";
say "\ttour     $path->@*";

($min, $path) = nn_bidirectional_ts( $mat );
say '';
say 'nearest neighbor bidirectional:';
say "\tmin dist $min";
say "\ttour     $path->@*";


($min, $path) = nn_ts( $mat );
say '';
say 'nearest neighbor:';
say "\tmin dist $min";
say "\ttour     $path->@*";


($min, $path) = insert_ts( $mat );
say '';
say 'nearest insertion:';
say "\tmin dist $min";
say "\ttour     $path->@*";



sub exact_ts ($mat) {
## naive exact implementation permuting and summing all possibilities. Only
## useful for smaller values of N, up to about 12
    return (0, []) if $mat->@* > 12;

    ## metainfo about matrix
    my %stats;
    
    ## starting city is at index 0
    my $start =  $mat->[0];
    
    ## permute cities other than start city by index
    my $iter = permutations( [0..scalar $mat->@*-2] );
    my $dist;
    my $sp;
    my $min = "Inf";
    while ( my $p = $iter->next ) {
    
        ## from start to first city
        $dist = $start->[ $p->[0]+1 ];                  

        ## loop through permutation of cities
        for my $i (0..$p->@*-2) {
            $dist += $mat->[ $p->[$i]+1 ][ $p->[$i+1]+1 ];
        }
        
        ## return to start
        $dist += $mat->[ $p->[ $p->@*-1 ]+1 ][ 0 ];     ## back to start

        if ( $dist < $min ) {
            $sp  = $p;
            $min = $dist;
        }
    }
    
    ## append and prepend 0 index to tour for completeness
    my $path = [ 0, (map { $_ + 1 } $sp->@*), 0 ];
    return ($min, $path);
}

sub nn_ts ($mat) {
## a nearest-neighbor heuristic
## as the graph is asymmetrical, we start at the shortest arc to ensure using it. Every 
## tour visits every city, but only use 1/2 of the arcs to complete a the specific path
## in the direction chosen.
    
    ## create a list of unvisited cities
    my %cities = map { $_ => 1 } keys $mat->@*;

    ## starting city holds shortest arc
    my ($start, $dist) = (0, "Inf");
    my @mins = map { my $idx = $_; min grep { $_ > 0 } ( $idx->@* ) } $mat->@*;
    while ( my ($k, $v) = each @mins ) {
        ($start, $dist) = ($k, $v) if $v < $dist;
    }
    my $city = first { $mat->[$start][$_] == $dist }     
                     (0..$mat->[$start]->@* - 1);

    ## start building the shortest path and removing visited cities from options
    my @sp = ( $start, $city );
    delete @cities{ @sp };

    while (scalar keys %cities) {
        my $min  = min( map { $mat->[$city][$_] } keys %cities );
        my $next = first { $mat->[$city][$_] == $min } 
            grep { exists $cities{$_} } (0..$mat->[$city]->@* - 1);

        $dist += $min;
        push @sp, $next;
        delete $cities{ "$next" };
        $city = $next;

    }
    
    ## link back to base, rotate and return
    $dist += $mat->[$city][$start];
    while ( $sp[0] ) { push @sp, shift @sp };
    return ( $dist, [ @sp, 0 ] );
}

sub nn_bidirectional_ts ($mat) {
## a nearest-neighbor heuristic
## bidirectional growth from both ends of the partial tour, selecting the
## best next step

    ## create a list of unvisited cities
    my %cities = map { $_ => 1 } keys $mat->@*;

    ## starting city holds shortest arc
    my ($start, $dist) = (0, "Inf");
    my @mins = map { my $idx = $_; min grep { $_ > 0 } ( $idx->@* ) } $mat->@*;
    while ( my ($k, $v) = each @mins ) {
        ($start, $dist) = ($k, $v) if $v < $dist;
    }
    my $city = first { $mat->[$start][$_] == $dist }     
                     (0..$mat->[$start]->@* - 1);

    ## start building the shortest path and removing visited cities from options
    my @sp = ( $start, $city );
    delete @cities{ @sp };

    while (scalar keys %cities) {
        my $min_end  = min( map { $mat->[$city][$_] } keys %cities );
        my $next_end = first { $mat->[$city][$_] == $min_end } 
            grep { exists $cities{$_} } (0..$mat->[$city]->@* - 1);

        my $min_start  = min( map { $mat->[$_][$start] } keys %cities );
        my $next_start = first { $mat->[$_][$start] == $min_start } 
            grep { exists $cities{$_} } (0..$mat->[$city]->@* - 1);
            
        if ($min_start < $min_end) {
            $dist += $min_start;

            unshift @sp, $next_start;
 
           delete $cities{ "$next_start" };
            $start = $next_start;
        }
        else {
            $dist += $min_end;

            push @sp, $next_end;

            delete $cities{ "$next_end" };
            $city = $next_end;    
        }
    }

    ## link back to base, rotate and return
    $dist += $mat->[$city][$start];
    while ( $sp[0] ) { push @sp, shift @sp };
    return ( $dist, [ @sp, 0 ] );
}


sub insert_ts ($mat) {
## an insertion heuristic
## an original amalgamation of several insertion algorithms

    ## some generic containers we'll be reusing
    my ($city, $dist);
    
    ## create a list of indexes of unvisited cities
    my %cities = map { $_ => 1 } keys $mat->@*;

    ## starting city holds shortest arc
    my ($start, $end);
    $dist = "Inf";
    my @mins = map { my $idx = $_; min grep { $_ > 0 } ( $idx->@* ) } 
                   $mat->@*;
    while ( my ($k, $v) = each @mins ) {
        ($start, $dist) = ($k, $v) if $v < $dist;
    }
    $end = first { $mat->[$start][$_] == $dist }     
                 (0..$mat->[$start]->@* - 1);
    delete @cities{ $start, $end };

    ## find the city that minimizes the distance from the tour end 
    ## to the new city and back to the start, to form a triangle 
    ## tried min and max, this seems slightly better. Should, in an 
    ## asymmetric matrix, perhaps be closest to the mean. 
    $dist = "Inf";
    for (sort keys %cities) {

        my $d = $mat->[$end][$_] + $mat->[$_][$start];

        ($city, $dist) = ($_, $d) if $d < $dist;
    }
    delete $cities{ $city };

    ## establish the working subtour
    my @tour = ( $start, $end, $city, $start );
    
    my $pick;
    while ( keys %cities ) {
        ## find the city with the shortest insertion
        for $city ( sort keys %cities ) {
            for my $start_index (0..@tour-2) {
                my $d = min ( $mat->[$start_index][$city], $mat->[$city][$start_index+1] );
                if ($d < $min) {
                    $pick = $city;
                }
            }
        }
    
        ## find the best insert point
        my @best = (undef, undef, "Inf");  #( city, $insert position, distance );
        for my $start_index (0..@tour-2) {
            my $cost = $mat->[$start_index][$pick] 
                        + $mat->[$pick][$start_index+1]
                        - $mat->[ $tour[$start_index] ][ $tour[$start_index+1] ];
            if ($cost < $best[2]) {
                @best = ( $pick, $start_index, $cost );
            }
        }

        ## and insert it into the tour after the start index
        splice @tour, $best[1]+1, 0, $best[0];
        delete $cities{ $best[0] };
    }

    pop @tour;
    while ( $tour[0] ) { push @tour, shift @tour };
    push @tour, 0;

    $dist = 0;
    for my $i ( 0..@tour-2 ) {
        $dist += $mat->[ $tour[$i] ][ $tour[$i+1] ]
    }
    
    return ($dist, \@tour);
}

## ## ## matrix construction functions


sub rand_amat ($size) {
## create a random asymmetric distance matrix of size $size
## for arcs of a complete graph

    $size -= 1;
    my @mat;
    
    for (0..$size) {
        my @row;
        push @row, int( rand($size*$size/2) + 1 ) for (0..$size);
        $row[$_] = 0;
        push @mat, \@row;
    }
    
    return \@mat;
}

sub rand_smat ($size) {
## create a random symmetric distance matrix of size $size
## for arcs of a complete graph

    $size -= 1;
    my @mat;
    
    for my $i (0..$size) {
        for my $j ($i..$size) {
            if ($i == $j) {
                $mat[$i][$j] = 0;
                next;
            }
            $mat[$i][$j] = $mat[$j][$i] = int( rand($size*$size) + 1 )
        }
    }
    
    return \@mat;
}


sub print_mat ($mat, $width = 5) {
## print matrix allowing space $width chars wide per element
    say '';
    
    my $format = ("%${width}d" x scalar $mat->@*) . "\n";
    for my $row ($mat->@*) {
        printf $format, $row->@*;
    }
    
}
