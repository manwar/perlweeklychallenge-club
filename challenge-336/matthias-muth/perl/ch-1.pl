#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 336 Task 1: Equal Group
#
#       Perl solution by Matthias Muth.
#

use v5.36;

use List::MoreUtils qw( frequency );
use Math::Prime::Util qw( divisors );
use List::Util qw( any );

sub equal_group( @ints ) {
    my %counts = frequency( @ints );
    my @all_divisors = grep $_ != 1, map divisors( $_ ), values %counts;
    my %divisor_frequencies = frequency @all_divisors;
    return any { $_ == scalar keys %counts } values %divisor_frequencies;
}

use Test2::V0 qw( -no_srand );

is equal_group( 1, 1, 2, 2, 2, 2 ), T,
    'Example 1: equal_group( 1, 1, 2, 2, 2, 2 ) is true';
is equal_group( 1, 1, 1, 2, 2, 2, 3, 3 ), F,
    'Example 2: equal_group( 1, 1, 1, 2, 2, 2, 3, 3 ) is false';
is equal_group( 5, 5, 5, 5, 5, 5, 7, 7, 7, 7, 7, 7 ), T,
    'Example 3: equal_group( 5, 5, 5, 5, 5, 5, 7, 7, 7, 7, 7, 7 ) is true';
is equal_group( 1, 2, 3, 4 ), F,
    'Example 4: equal_group( 1, 2, 3, 4 ) is false';
is equal_group( 8, 8, 9, 9, 10, 10, 11, 11 ), T,
    'Example 5: equal_group( 8, 8, 9, 9, 10, 10, 11, 11 ) is true';

done_testing;
