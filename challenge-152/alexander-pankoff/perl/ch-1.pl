#!/usr/bin/env perl
use strict;
use warnings;
use feature qw'say state signatures';
no warnings qw'experimental::signatures';

# TASK #1 › Triangle Sum Path
# Submitted by: Mohammad S Anwar
#
# You are given a triangle array.
#
# Write a script to find the minimum sum path from top to bottom.
# Example 1:
#
# Input: $triangle = [ [1], [5,3], [2,3,4], [7,1,0,2], [6,4,5,2,8] ]
#
#                 1
#                5 3
#               2 3 4
#              7 1 0 2
#             6 4 5 2 8
#
# Output: 8
#
#     Minimum Sum Path = 1 + 3 + 2 + 0 + 2 => 8
#
# Example 2:
#
# Input: $triangle = [ [5], [2,3], [4,1,5], [0,1,2,3], [7,2,4,1,9] ]
#
#                 5
#                2 3
#               4 1 5
#              0 1 2 3
#             7 2 4 1 9
#
# Output: 9
#
#     Minimum Sum Path = 5 + 2 + 1 + 0 + 1 => 9

use List::Util qw(min sum0);

run() unless caller();

sub run() {
    my $example1 =
      [ [1], [ 5, 3 ], [ 2, 3, 4 ], [ 7, 1, 0, 2 ], [ 6, 4, 5, 2, 8 ] ];
    my $example2 =
      [ [5], [ 2, 3 ], [ 4, 1, 5 ], [ 0, 1, 2, 3 ], [ 7, 2, 4, 1, 9 ] ];
    say "Running example 1";
    say minimum_triangle_sum_path($example1);
    say "Running example 2";
    say minimum_triangle_sum_path($example2);
}

sub minimum_triangle_sum_path($triangle) {
    return sum0( map { min(@$_) } @$triangle );
}
