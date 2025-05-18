#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 321 Task 1: Distinct Average
#
#       Perl solution by Matthias Muth.
#

use v5.36;

sub distinct_average( @nums ) {
    @nums = sort { $a <=> $b } @nums;
    my %distinct_values;
    while ( @nums >= 2 ) {
        $distinct_values{ ( shift( @nums ) + pop @nums ) / 2 } = 1;
    }
    return scalar %distinct_values;
}

use Test2::V0 qw( -no_srand );

is distinct_average( 1, 2, 4, 3, 5, 6 ), 1,
    'Example 1: distinct_average( 1, 2, 4, 3, 5, 6 ) == 1';
is distinct_average( 0, 2, 4, 8, 3, 5 ), 2,
    'Example 2: distinct_average( 0, 2, 4, 8, 3, 5 ) == 2';
is distinct_average( 7, 3, 1, 0, 5, 9 ), 2,
    'Example 3: distinct_average( 7, 3, 1, 0, 5, 9 ) == 2';

done_testing;
