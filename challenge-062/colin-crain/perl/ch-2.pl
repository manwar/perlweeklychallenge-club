#! /opt/local/bin/perl
#
#       62_2_spacequeen.pl
#
#
#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use feature ":5.26";

use POSIX qw( ceil );
use List::Util qw( all );

## ## ## ## ## MAIN:
my $then = time;

my $size = shift // 3;
my $base_board = build_gameboard( $size );
my $solution = [];
my $count;

my $starting_positions = get_initial_section( $size );
for my $start ( $starting_positions->@* ) {
    my $this_board = remove_conflicts( $base_board, $start );
    my $queenlist = [$start];
    place_next_queen($this_board, $queenlist, $solution);
}

say "$count solutions checked";
say "max solution:";
say +(scalar $solution->@*), " queens";
for my $square ($solution->@*) {
    say "[", $square, "]";
}

say "elapsed: ", time - $then;

## ## ## ## ## SUBS:

sub place_next_queen {
## select an open position on the board and continue the recursion
## after removing conflicts from the new queen
    my ($board, $queenlist) = @_;
    my @open_positions = keys $board->{squares}->%*;
    for my $queen ( @open_positions ) {
        my $new_list  = [$queenlist->@*, $queen];
        my $new_board = remove_conflicts( $board, $queen );

        if (scalar keys $new_board->{squares}->%* == 0) {
            $count++;
            if (scalar @$new_list > scalar @$solution) {
                $solution = $new_list;
                say "solutions searched so far: ", $count, "\n", (join ", ", $new_list->@*);
            }
            return;
        }
        place_next_queen( $new_board, $new_list);
    }
}

sub remove_conflicts {
## given a board and a queen placement hashkey,
## calculates attack vectors for the queen and removes conflicting
## squares from the board
## returns new board
    my ($prev_board, $queen) = @_;
    my %squares = $prev_board->{squares}->%*;
    my $board = { "size" => $prev_board->{size},
                  "squares" => \%squares };

    my $conflicts = attack_vectors( $board->{squares}->{$queen}, $board->{size} );
    for my $squarekey ( $conflicts->@* ) {
        delete $board->{squares}->{$squarekey}
    }
    delete $board->{squares}->{$queen};
    return $board;
}

sub build_gameboard {
## given a cardinal size of one edge
## a hash of every square in the cube
## keys are stringified points
## values are array refs to those points as [$x, $y, $z]
## returns reference
    my $size = shift;
    my $board = {};
    $board->{size} = $size;
    for my $x (0..$size-1) {
        for my $y (0..$size-1) {
            for my $z (0..$size-1) {
                my $key = hashkey([$x, $y, $z], $size);
                $board->{squares}->{$key} = [$x, $y, $z];
            }
        }
    }
    return $board;
}

sub get_initial_section {
## under the many symmetries in the cube, most initial positions are
## equivalent under rotation or mirroring to many others. This function
## returns a minimal set of starting points on the gameboard that taken
## together under transformation represent the entirety.
## On a 5x5x5 board the squares
##           (0,0,0)(1,0,0)(2,0,0)
##                  (1,1,0)(2,1,0)
##                         (2,2,0)
##                  (1,1,1)(2,1,1)
##                         (2,2,1)
##                         (2,2,2)
## can be mapped to all other
## possible starts. This tetrahedron can be as little as 1/48* of the initial
## possibility space, but because the squares divided along the lines of symmetry
## are included whole, the actual count will be higher, converging on 1/48.
#
## * "I have a truly marvelous demonstration of this proposition
##    which this margin is too narrow to contain."

    my $size = shift;
    my $end = ceil(($size)/2)-1;
    my @output;
    my ($x, $y, $z);
    for $z (0..$end) {
        for $y ( $z..$end) {
            for $x ($y..$end) {
                push @output, [$x,$y,$z];
            }
        }
    }
    my @keys = map {hashkey($_, $size)} @output;
    return \@keys;
}

sub attack_vectors {
## given a queen as [x,y,z]
## calculates spacequeen attack vectors within a cube of a given size
## returns a list of attack squares as hashkeys
    my ($queen, $size) = @_;
    # say "($queen, $size)";
    my ($x, $y, $z) = $queen->@*;
    my @attacks;

    ## Rook attacks
    for my $n (0..$size-1) {
            push @attacks, ([$n,$y,$z]) unless $n == $x;
            push @attacks, ([$x,$n,$z]) unless $n == $y;
            push @attacks, ([$x,$y,$n]) unless $n == $z;
    }

    ## Bishop attacks
    for my $n (0..$size-1) {
        ## y∝x n->x' y=(1|-1)x + b
        push @attacks, ([$n,$n+($y-$x),$z],[$n,-$n+($y+$x),$z]) unless $n == $x;
        ## z∝x n->x' z=(1|-1)x + b
        push @attacks, ([$n,$y,$n+($z-$x)],[$n,$y,-$n+($z+$x)]) unless $n == $x;
        ## z∝y n->y' z=(1|-1)y + b
        push @attacks, ([$x,$n,$n+($z-$y)],[$x,$n,-$n+($z+$y)]) unless $n == $y;
    }

    ## Unicorn attacks
    for my $n (0..$size-1) {
        ## (0,0,0)->(n,n,n) axis
        push @attacks, ([$n,$n+($y-$x),$n+($z-$x)])   unless $n == $x;
        ## (n,0,0)->(0,n,n) axis
        push @attacks, ([$n,-$n+($y+$x),-$n+($z+$x)]) unless $n == $x;
        ## (0,n,0)->(n,0,n) axis
        push @attacks, ([$n,-$n+($y+$x),$n+($z-$x)])  unless $n == $x;
        ## (n,n,0)->(0,0,n) axis
        push @attacks, ([$n,$n+($y-$x),-$n+($z+$x)])  unless $n == $x;
    }

    ## filter out out-of-range attacks
    my @output = grep {
                       (all {$_ >= 0} $_->@*) && (all {$_ < $size} $_->@*)
                       } @attacks;

    ## convert to hashkeys
    my @keys = map {hashkey($_, $size)} @output;
    return \@keys;
}

sub hashkey {
    my ($point, $size) = @_;
    my $digits = scalar( split //, $size-1 ) ;
    my $key_format = join '', ('%0'.$digits.'d') x 3;
    my $key = sprintf $key_format, $point->@*;
    return $key;
}
