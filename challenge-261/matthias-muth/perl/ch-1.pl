#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 261 Task 1: Element Digit Sum
#
#       Perl solution by Matthias Muth.
#

use v5.36;
use List::Util qw( sum );

sub element_digit_sum( @ints ) {
    return abs( sum( @ints ) - sum( map split( "", $_ ), @ints ) );
}

use Test2::V0 qw( -no_srand );
is element_digit_sum( 1, 2, 3, 45 ), 36,
    'Example 1: element_digit_sum( 1, 2, 3, 45 ) == 36';
is element_digit_sum( 1, 12, 3 ), 9,
    'Example 2: element_digit_sum( 1, 12, 3 ) == 9';
is element_digit_sum( 1, 2, 3, 4 ), 0,
    'Example 3: element_digit_sum( 1, 2, 3, 4 ) == 0';
is element_digit_sum( 236, 416, 336, 350 ), 1296,
    'Example 4: element_digit_sum( 236, 416, 336, 350 ) == 1296';
done_testing;
