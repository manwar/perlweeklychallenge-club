#!/usr/bin/perl

# Challenge 100
#
# TASK #2 > Triangle Sum
# Submitted by: Mohammad S Anwar
# You are given triangle array.
#
# Write a script to find the minimum path sum from top to bottom.
#
# When you are on index i on the current row then you may move to either
# index i or index i + 1 on the next row.
#
# Example 1:
# Input: Triangle = [ [1], [2,4], [6,4,9], [5,1,7,2] ]
# Output: 8
#
# Explanation: The given triangle
#
#             1
#            2 4
#           6 4 9
#          5 1 7 2
#
# The minimum path sum from top to bottom:  1 + 2 + 4 + 1 = 8
#
#              [1]
#            [2]  4
#            6 [4] 9
#           5 [1] 7 2
# Example 2:
# Input: Triangle = [ [3], [3,1], [5,2,3], [4,3,1,3] ]
# Output: 7
#
# Explanation: The given triangle
#
#             3
#            3 1
#           5 2 3
#          4 3 1 3
#
# The minimum path sum from top to bottom: 3 + 1 + 2 + 1 = 7
#
#              [3]
#             3  [1]
#            5 [2] 3
#           4 3 [1] 3

use strict;
use warnings;
use 5.030;

@ARGV or die "Usage: ch-2.pl row1 row2 ...\n";
my @triangle = parse(@ARGV);
say min_sum(@triangle);

sub parse {
    my(@rows) = @_;
    my @triangle;
    my $i = 1;
    while (@rows) {
        my @row = split(/\D+/, shift(@rows));
        @row==$i or die "malformed triangle row $i\n";
        push @triangle, \@row;
        $i++;
    }
    return @triangle;
}

sub min_sum {
    my(@triangle) = @_;
    return min_sum_1(0, 0, 0, \@triangle);
}

sub min_sum_1 {
    my($sum, $r, $c, $triangle) = @_;
    $sum += $triangle->[$r][$c];
    if ($r == $#$triangle) {                # bottom row
        return $sum;
    }
    else {
        my $sum1 = min_sum_1($sum, $r+1, $c,   $triangle);
        my $sum2 = min_sum_1($sum, $r+1, $c+1, $triangle);
        return $sum1<$sum2 ? $sum1 : $sum2;
    }
}
