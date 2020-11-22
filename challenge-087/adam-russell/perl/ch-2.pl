use strict;
use warnings;
##
# You are given matrix m x n with 0 and 1.
# Write a script to find the largest rectangle 
# containing only 1. Print 0 if none found.
##
use boolean;

sub print_solution{
    my($m, $n) = @_;
    if(!$m || !$n){
        print "0\n";
    }
    else{
        for (1 .. $n){
            print "[". join(" ", (1)x $m) . "]\n";
        }       
    }
}

sub evaluate{
    my($m, $n, $matrix) = @_;
    my $row_string = join(",", (1) x $m);
    my $columns = 0;
    for my $row (@{$matrix}){
        my $test = join(",", @{$row});
        if(index($test, $row_string) > -1){
            $columns++;
            return true if($columns == $n);
        }
        else{
            $columns = 0;
        }
    }
    return false;
}

sub largest_rectangle{
    my @matrix = @_;
    my $rows = @{$matrix[0]};
    my $columns = @matrix;
    my $max_area = 0;
    my @rectangle;
    for my $m (2 .. $columns){
        for my $n (1 .. $rows){
            if(evaluate($m, $n, \@matrix)){
                if(($m * $n) > $max_area){
                    $max_area = ($m * $n);
                    @rectangle = ($m, $n);
                }
            }
        }
    }
    return @rectangle;
}

MAIN:{
    my @MATRIX = (
        [0, 0, 0, 1, 0, 0],
        [1, 1, 1, 0, 0, 0],
        [0, 0, 1, 0, 0, 1],
        [1, 1, 1, 1, 1, 0],
        [1, 1, 1, 1, 1, 0]
    );
    print_solution(largest_rectangle(@MATRIX));
    @MATRIX = (
        [1, 0, 1, 0, 1, 0],
        [0, 1, 0, 1, 0, 1],
        [1, 0, 1, 0, 1, 0],
        [0, 1, 0, 1, 0, 1]
    );
    print_solution(largest_rectangle(@MATRIX));
    @MATRIX = (
        [0, 0, 0, 1, 1, 1],
        [1, 1, 1, 1, 1, 1],
        [0, 0, 1, 0, 0, 1],
        [0, 0, 1, 1, 1, 1],
        [0, 0, 1, 1, 1, 1]
    );
    print_solution(largest_rectangle(@MATRIX));  
}