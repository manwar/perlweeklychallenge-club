#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 334 Task 1: Range Sum
#
#       Perl solution by Matthias Muth.
#

use v5.36;
use List::Util qw( sum );

sub range_sum( $ints, $x, $y ) {
    return sum( $ints->@[$x..$y] );
}

use Test2::V0 qw( -no_srand );

is range_sum( [-2, 0, 3, -5, 2, -1], 0, 2 ), 1,
    'Example 1: range_sum( [-2, 0, 3, -5, 2, -1], 0, 2 ) == 1';
is range_sum( [1, -2, 3, -4, 5], 1, 3 ), -3,
    'Example 2: range_sum( [1, -2, 3, -4, 5], 1, 3 ) == -3';
is range_sum( [1, 0, 2, -1, 3], 3, 4 ), 2,
    'Example 3: range_sum( [1, 0, 2, -1, 3], 3, 4 ) == 2';
is range_sum( [-5, 4, -3, 2, -1, 0], 0, 3 ), -2,
    'Example 4: range_sum( [-5, 4, -3, 2, -1, 0], 0, 3 ) == -2';
is range_sum( [-1, 0, 2, -3, -2, 1], 0, 2 ), 1,
    'Example 5: range_sum( [-1, 0, 2, -3, -2, 1], 0, 2 ) == 1';

done_testing;
