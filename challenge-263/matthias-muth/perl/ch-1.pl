#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 263 Task 1: Target Index
#
#       Perl solution by Matthias Muth.
#

use v5.36;

sub target_index( $ints, $k ) {
    my @ints = sort $ints->@*;
    return grep $ints[$_] == $k, 0..$#ints;
}

use Test2::V0 qw( -no_srand );
is [ target_index( [1, 5, 3, 2, 4, 2], 2 ) ], [ 1, 2 ],
    'Example 1: target_index( [1, 5, 3, 2, 4, 2], 2 ) == (1, 2)';
is [ target_index( [1, 2, 4, 3, 5], 6 ) ], [  ],
    'Example 2: target_index( [1, 2, 4, 3, 5], 6 ) == ()';
is [ target_index( [5, 3, 2, 4, 2, 1], 4 ) ], [ 4 ],
    'Example 3: target_index( [5, 3, 2, 4, 2, 1], 4 ) == 4';
done_testing;
