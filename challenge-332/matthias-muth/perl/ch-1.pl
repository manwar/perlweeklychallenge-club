#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 332 Task 1: Binary Date
#
#       Perl solution by Matthias Muth.
#

use v5.36;

sub binary_date( $date ) {
    return sprintf "%b-%b-%b", $date =~ /\d+/g;
}

use Test2::V0 qw( -no_srand );

is binary_date( "2025-07-26" ), "11111101001-111-11010",
    'Example 1: binary_date( "2025-07-26" ) == "11111101001-111-11010"';
is binary_date( "2000-02-02" ), "11111010000-10-10",
    'Example 2: binary_date( "2000-02-02" ) == "11111010000-10-10"';
is binary_date( "2024-12-31" ), "11111101000-1100-11111",
    'Example 3: binary_date( "2024-12-31" ) == "11111101000-1100-11111"';

done_testing;
