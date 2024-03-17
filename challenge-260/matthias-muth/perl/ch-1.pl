#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 260 Task 1: Unique Occurrences
#
#       Perl solution by Matthias Muth.
#

use v5.36;

use List::Util qw( uniq );

sub unique_occurrences( @ints ) {
    my %freq;
    ++$freq{$_}
	for @ints;
    return uniq( values %freq ) == scalar values %freq ? 1 : 0;
}

use Test2::V0 qw( -no_srand );
is unique_occurrences( 1, 2, 2, 1, 1, 3 ), 1,
    'Example 1: unique_occurrences( 1, 2, 2, 1, 1, 3 ) == 1';
is unique_occurrences( 1, 2, 3 ), 0,
    'Example 2: unique_occurrences( 1, 2, 3 ) == 0';
is unique_occurrences( -2, 0, 1, -2, 1, 1, 0, 1, -2, 9 ), 1,
    'Example 3: unique_occurrences( -2, 0, 1, -2, 1, 1, 0, 1, -2, 9 ) == 1';
done_testing;
