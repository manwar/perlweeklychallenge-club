#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 327 Task 1: Missing Integers
#
#       Perl solution by Matthias Muth.
#

use v5.36;

sub missing_integers( @ints ) {
    my %exists = map { ( $_ => 1 ) } @ints;
    return grep ! $exists{$_}, 1..@ints;
}

use Test2::V0 qw( -no_srand );

is [ missing_integers( 1, 2, 1, 3, 2, 5 ) ], [ 4, 6 ],
    'Example 1: missing_integers( 1, 2, 1, 3, 2, 5 ) == (4, 6)';
is [ missing_integers( 1, 1, 1 ) ], [ 2, 3 ],
    'Example 2: missing_integers( 1, 1, 1 ) == (2, 3)';
is [ missing_integers( 2, 2, 1 ) ], [ 3 ],
    'Example 3: missing_integers( 2, 2, 1 ) == 3';

done_testing;
