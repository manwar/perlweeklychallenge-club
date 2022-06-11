#!/usr/bin/env perl

# Challenge 064
#
# TASK #1 › Minimum Sum Path
# Submitted by: Mohammad S Anwar
# Reviewed by: Ryan Thompson
#
# Given an m × n matrix with non-negative integers, write a script to find a
# path from top left to bottom right which minimizes the sum of all numbers
# along its path. You can only move either down or right at any point in time.
#
# Example
# Input:
#
# [ 1 2 3 ]
# [ 4 5 6 ]
# [ 7 8 9 ]
# The minimum sum path looks like this:
#
# 1?2?3
#     ?
#     6
#     ?
#     9
# Thus, your script could output: 21 ( 1 ? 2 ? 3 ? 6 ? 9 )

use Modern::Perl;
use Test::More;

my @m = ([1,2,3],
         [4,5,6],
         [7,8,9]);

is min_sum(@m), 21;
done_testing;

sub min_sum {
    my(@m) = @_;
    our $min_sum = 1e6;
    min_sum1(0, 0, 0, @m);
    return $min_sum;
}

sub min_sum1 {
    my($sum, $r, $c, @m) = @_;
    our $min_sum;

    my $rows = scalar(@m);
    my $cols = scalar(@{$m[0]});
    $sum += $m[$r][$c];
    if ($r==$rows-1 && $c==$cols-1) {   # reached end
        if ($sum < $min_sum) {
            $min_sum = $sum;
        }
    }
    else {
        if ($r+1 < $rows) {
            min_sum1($sum, $r+1, $c, @m);
        }
        if ($c+1 < $cols) {
            min_sum1($sum, $r, $c+1, @m);
        }
    }
}
