#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 361 Task 1: Zeckendorf Representation
#
#       Perl solution by Matthias Muth.
#

use v5.36;

sub zeckendorf_representation( $int ) {
    my @fib = ( 1, 2 );
    push @fib, $fib[-2] + $fib[-1]
        until $fib[-1] >= $int;
    return map { $_ <= $int ? do { $int -= $_; $_ } : () } reverse @fib;
}

use Test2::V0 qw( -no_srand );

is [ zeckendorf_representation( 4 ) ], [ 3, 1 ],
    'Example 1: zeckendorf_representation( 4 ) == (3, 1)';
is [ zeckendorf_representation( 12 ) ], [ 8, 3, 1 ],
    'Example 2: zeckendorf_representation( 12 ) == (8, 3, 1)';
is [ zeckendorf_representation( 20 ) ], [ 13, 5, 2 ],
    'Example 3: zeckendorf_representation( 20 ) == (13, 5, 2)';
is [ zeckendorf_representation( 96 ) ], [ 89, 5, 2 ],
    'Example 4: zeckendorf_representation( 96 ) == (89, 5, 2)';
is [ zeckendorf_representation( 100 ) ], [ 89, 8, 3 ],
    'Example 5: zeckendorf_representation( 100 ) == (89, 8, 3)';

done_testing;
