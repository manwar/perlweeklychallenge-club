#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 283 Task 1: Unique Number
#
#       Perl solution by Matthias Muth.
#

use v5.36;

use List::MoreUtils qw( singleton );

sub unique_number( @ints ) {
    my @s = singleton( @ints );
    return @s == 1 ? $s[0] : ();
}

use Test2::V0 qw( -no_srand );
is unique_number( 3, 3, 1 ), 1,
    'Example 1: unique_number( 3, 3, 1 ) == 1';
is unique_number( 3, 2, 4, 2, 4 ), 3,
    'Example 2: unique_number( 3, 2, 4, 2, 4 ) == 3';
is unique_number( 1 ), 1,
    'Example 3: unique_number( 1 ) == 1';
is unique_number( 4, 3, 1, 1, 1, 4 ), 3,
    'Example 4: unique_number( 4, 3, 1, 1, 1, 4 ) == 3';
is unique_number( 1, 1, 2, 2 ), undef,
    'Test 1: unique_number( 1, 1, 2, 2 ) == undef';
is unique_number( 1, 2, 3 ), undef,
    'Test 2: unique_number( 1, 2, 3 ) == undef';
done_testing;
