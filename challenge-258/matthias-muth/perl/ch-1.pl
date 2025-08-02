#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 258 Task 1: Count Even Digits Number
#
#       Perl solution by Matthias Muth.
#

use v5.36;

sub count_even_digits_number( @ints ) {
    return scalar grep length( $_ ) % 2 == 0, @ints;
}

use Test2::V0 qw( -no_srand );
is count_even_digits_number( 10, 1, 111, 24, 1000 ), 3,
    'Example 1: count_even_digits_number( 10, 1, 111, 24, 1000 ) == 3';
is count_even_digits_number( 111, 1, 11111 ), 0,
    'Example 2: count_even_digits_number( 111, 1, 11111 ) == 0';
is count_even_digits_number( 2, 8, 1024, 256 ), 1,
    'Example 3: count_even_digits_number( 2, 8, 1024, 256 ) == 1';
done_testing;
