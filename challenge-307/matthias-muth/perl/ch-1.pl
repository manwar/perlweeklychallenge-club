#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 307 Task 1: Check Order
#
#       Perl solution by Matthias Muth.
#

use v5.36;

sub check_order( @ints ) {
    my @sorted = sort { $a <=> $b } @ints;
    return grep $sorted[$_] != $ints[$_], keys @sorted;
}

use Test2::V0 qw( -no_srand );
use Data::Dump qw( pp );

is [ check_order( 5, 2, 4, 3, 1 ) ], [ 0, 2, 3, 4 ],
    'Example 1: check_order( 5, 2, 4, 3, 1 ) == (0, 2, 3, 4)';
is [ check_order( 1, 2, 1, 1, 3 ) ], [ 1, 3 ],
    'Example 2: check_order( 1, 2, 1, 1, 3 ) == (1, 3)';
is [ check_order( 3, 1, 3, 2, 3 ) ], [ 0, 1, 3 ],
    'Example 3: check_order( 3, 1, 3, 2, 3 ) == (0, 1, 3)';

done_testing;
