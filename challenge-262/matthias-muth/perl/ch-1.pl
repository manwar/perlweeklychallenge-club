#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 262 Task 1: Max Positive Negative
#
#       Perl solution by Matthias Muth.
#

use v5.36;

use List::Util qw( max );

sub max_positive_negative( @ints ) {
    return max( scalar( grep $_ < 0, @ints ), scalar( grep $_ > 0, @ints ) );
}

use Test2::V0 qw( -no_srand );
is max_positive_negative( -3, 1, 2, -1, 3, -2, 4 ), 4,
    'Example 1: max_positive_negative( -3, 1, 2, -1, 3, -2, 4 ) == 4';
is max_positive_negative( -1, -2, -3, 1 ), 3,
    'Example 2: max_positive_negative( -1, -2, -3, 1 ) == 3';
is max_positive_negative( 1, 2 ), 2,
    'Example 3: max_positive_negative( 1, 2 ) == 2';
done_testing;
