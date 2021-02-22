#!/usr/bin/perl
# The Weekly Challenge 093
# Task 1 Max Points
# I choose to interpret the task as only integer 
# coordinates are allowed and the "lines" are only the 
# diagonals, horizontals or verticals because
# I find it fun to show it can inplement as an O(n log n) solution,
# instead of O(n^2) solution of BF for a more general case.
# ref: https://stackoverflow.com/questions/4179581/what-is-the
# -most-efficient-algorithm-to-find-a-straight-line-that-goes-through-m
use strict;
use warnings;
use List::Util qw/max/;
use Test::More tests => 2 ;

my @coordinates = ([1,1], [2,2], [3,1], [1,3], [5,3] );

sub max_points {
    my $max = 1;
    my @line_char = @_;
    my $count = 1;
    my $pre = shift @line_char;
    for (@line_char) {
        if ($_ != $pre) {
            $max = $count if $count > $max;
            $pre = $_;
            $count = 1;
        } else {
            $count++;
        }
    }
    $max = $count if $count > $max;
    return $max;
}

sub max_colinear_points {
    my @coord = @_;
    my @nw_line_char = sort {$a<=>$b} map {$_->[0]+$_->[1]} @coord;
    my @ne_line_char = sort {$a<=>$b} map {$_->[0]-$_->[1]} @coord;
    my @ver_line_char = sort {$a<=>$b} map {$_->[0]} @coord;  # see  
    my @hor_line_char = sort {$a<=>$b} map {$_->[1]} @coord;  # Remark

    print "\n";
    return max  max_points(@nw_line_char),max_points(@ne_line_char),
            max_points(@hor_line_char), max_points(@ver_line_char);
}


ok (max_colinear_points([3,5],[2,4],[3,4],[4,4],[1,3],[2,3],[3,3],
    [4,3],[5,3],[2,2],[3,2],[4,2],[3,1]) == 5,  "Test Case diamond " );

ok (max_colinear_points([1,1],[2,2],[3,3]) == 3, "Example 1");

# Remark:
# Interchange the ->[0] and ->[1] in correct order; 31st Jan 2021
