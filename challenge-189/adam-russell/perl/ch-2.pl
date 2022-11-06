use v5.36;
use strict;
use warnings;
##
# You are given an array of 2 or more non-negative integers.
# Write a script to find out the smallest slice, i.e. contiguous 
# subarray of the original array, having the degree of the given array.
##
sub array_degree{
    my(@integers) = @_;
    my @counts;
    map { $counts[$_]++ } @integers;
    @counts = grep {defined} @counts;
    return [sort {$b <=> $a} @counts]->[0];
}

sub least_slice_degree{
    my(@integers) = @_;
    my @minimum_length_slice;
    my $minimum_length = @integers;
    my $array_degree = array_degree(@integers);
    for my $i (0 .. @integers - 1){
        for my $j ($i + 1 .. @integers - 1){
            if(array_degree(@integers[$i .. $j]) == $array_degree && @integers[$i .. $j] < $minimum_length){
                @minimum_length_slice = @integers[$i .. $j];
                $minimum_length = @minimum_length_slice;
            }
        }
    }
    return @minimum_length_slice;
}

MAIN:{
    say "(" . join(", ", least_slice_degree(1, 3, 3, 2)) . ")";
    say "(" . join(", ", least_slice_degree(1, 2, 1)) . ")";
    say "(" . join(", ", least_slice_degree(1, 3, 2, 1, 2)) . ")";
    say "(" . join(", ", least_slice_degree(1, 1 ,2 ,3, 2)) . ")";
    say "(" . join(", ", least_slice_degree(2, 1, 2, 1, 1)) . ")";
}