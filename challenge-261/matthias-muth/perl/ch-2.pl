#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 261 Task 2: Multiply by Two
#
#       Perl solution by Matthias Muth.
#

use v5.36;

sub multiply_by_two( $ints, $start ) {
    my %set_of_ints = map { ( $_ => 1 ) } $ints->@*;
    my $product = $start;
    $product *= 2
	while exists $set_of_ints{$product};
    return $product;
}

use Test2::V0 qw( -no_srand );
is multiply_by_two( [5, 3, 6, 1, 12], 3 ), 24,
    'Example 1: multiply_by_two( [5, 3, 6, 1, 12], 3 ) == 24';
is multiply_by_two( [1, 2, 4, 3], 1 ), 8,
    'Example 2: multiply_by_two( [1, 2, 4, 3], 1 ) == 8';
is multiply_by_two( [5, 6, 7], 2 ), 2,
    'Example 3: multiply_by_two( [5, 6, 7], 2 ) == 2';
done_testing;
