#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 339 Task 2: Peak Point
#
#       Perl solution by Matthias Muth.
#

use v5.36;

use List::Util qw( reductions max );

sub peak_point( @gain ) {
    return max( reductions { $a + $b } 0, @gain );
}

use Test2::V0 qw( -no_srand );

is peak_point( -5, 1, 5, -9, 2 ), 1,
    'Example 1: peak_point( -5, 1, 5, -9, 2 ) == 1';
is peak_point( 10, 10, 10, -25 ), 30,
    'Example 2: peak_point( 10, 10, 10, -25 ) == 30';
is peak_point( 3, -4, 2, 5, -6, 1 ), 6,
    'Example 3: peak_point( 3, -4, 2, 5, -6, 1 ) == 6';
is peak_point( -1, -2, -3, -4 ), 0,
    'Example 4: peak_point( -1, -2, -3, -4 ) == 0';
is peak_point( -10, 15, 5 ), 10,
    'Example 5: peak_point( -10, 15, 5 ) == 10';

done_testing;
