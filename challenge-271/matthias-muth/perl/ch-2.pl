#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 271 Task 2: Sort by 1 bits
#
#       Perl solution by Matthias Muth.
#

use v5.36;

sub n_bits( $n ) {
    return unpack "%b*", pack "i", $n;
}

sub sort_by_1_bits( @ints ) {
    return sort { n_bits( $a ) <=> n_bits( $b ) || $a <=> $b } @ints;
}

use Test2::V0 qw( -no_srand );
is [ sort_by_1_bits( 0, 1, 2, 3, 4, 5, 6, 7, 8 ) ], [ 0, 1, 2, 4, 8, 3, 5, 6, 7 ],
    'Example 1: sort_by_1_bits( 0, 1, 2, 3, 4, 5, 6, 7, 8 ) == (0, 1, 2, 4, 8, 3, 5, 6, 7)';
is [ sort_by_1_bits( 1024, 512, 256, 128, 64 ) ], [ 64, 128, 256, 512, 1024 ],
    'Example 2: sort_by_1_bits( 1024, 512, 256, 128, 64 ) == (64, 128, 256, 512, 1024)';
done_testing;
