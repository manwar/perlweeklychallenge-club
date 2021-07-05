use strict;
use warnings;
##
# You are given size of a triangle.
# Write a script to find all possible paths from top to the bottom right corner.
##
use constant FINAL => "end"; 
use constant DEADEND => "-1"; 
use constant TRIANGLE_TOP => q|/\\| ;
use constant TRIANGLE_BOTTOM => q|/__\\|;

sub find_paths{
    my($n) = @_;
    my %paths;
    my @complete_paths;
    my @vertices; 
    for my $i (0 .. $n){
        for my $j (0 .. $i){
            push @vertices, "$i-$j";
        }
    }
    $paths{""}=["0-0",["0-0"]];    
    my %updated_paths;
    while((keys %paths) > 0){
        %updated_paths = ();
        for my $path (keys %paths){
            my @exists;
            my @visited; 
            my $current = $paths{$path}->[0];  
            my $visited = $paths{$path}->[1];
            my @ij = split(/\-/, $current);  
            my($left, $horizontal, $right) = (($ij[0] + 1) . "-" . $ij[1], $ij[0] . "-" . ($ij[1] + 1), ($ij[0] + 1) . "-" . ($ij[1] + 1));
            @exists = grep {$_ eq $left} @vertices;
            @visited = grep {$_ eq $left} @{$visited};
            if(@exists && !@visited){
               my $visited_left = [@{$visited}, $left];
               if($left eq "$n-$n"){
                   push @complete_paths, $path . "L"; 
               }
               else{
                   $updated_paths{$path . "L"} = [$left, $visited_left];     
               }
            }          
            @exists = grep {$_ eq $horizontal} @vertices;
            @visited = grep {$_ eq $horizontal} @{$visited};
            if(@exists && !@visited){
               my $visited_horizontal = [@{$visited}, $horizontal];
               if($horizontal eq "$n-$n"){
                   push @complete_paths, $path . "H"; 
               }
               else{
                   $updated_paths{$path . "H"} = [$horizontal, $visited_horizontal];     
               }
            }           
            @exists = grep {$_ eq $right} @vertices;
            @visited = grep {$_ eq $right} @{$visited};
            if(@exists && !@visited){
               my $visited_right = [@{$visited}, $right];
               if($right eq "$n-$n"){
                   push @complete_paths, $path . "R"; 
               }
               else{
                   $updated_paths{$path . "R"} = [$right, $visited_right];     
               }
            }           
        }  
        %paths = %updated_paths;  
    }   
    return @complete_paths; 
}

sub print_triangle{
    my($n) = @_;
    my $top = TRIANGLE_TOP . "  ";
    for my $i (1 .. $n ){
        print " ";
        print "  " x ($n - $i);
        print $top x $i  ;
        print "\n";
        print "  " x ($n - $i );
        print TRIANGLE_BOTTOM x ($i );
        print "\n";
    }
}

MAIN:{
    my($N);
    $N = 1;
    print_triangle($N);
    for my $path (find_paths($N)){
        print "$path ";
    } 
    print "\n"; 
    $N = 2;
    print_triangle($N);
    for my $path (find_paths($N)){
        print "$path ";
    } 
    print "\n"; 
    $N = 3;
    print_triangle($N);
    for my $path (find_paths($N)){
        print "$path ";
    } 
    print "\n"; 
    $N = 4;
    print_triangle($N);
    for my $path (find_paths($N)){
        print "$path ";
    } 
    print "\n"; 
}
