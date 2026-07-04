#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 380 Task 1: Sum of Frequencies
#
#       Perl solution by Matthias Muth.
#

use v5.36;

use List::Util qw( max );

sub sum_of_frequencies( $str ) {
    my ( %vowel_freqs, %other_freqs );
    /^[aeiou]/ ? ++$vowel_freqs{$_} : ++$other_freqs{$_}
        for fc( $str ) =~ /[a-z]/g;
    return max( 0, values %vowel_freqs ) + max( 0, values %other_freqs );
}

use Test2::V0 qw( -no_srand );

my @tests = (
    [ "Example 1", "banana", 5 ],
    [ "Example 2", "teestett", 7 ],
    [ "Example 3", "aeiouuaa", 3 ],
    [ "Example 4", "rhythm", 2 ],
    [ "Example 5", "x", 1 ],
);

is sum_of_frequencies( $_->[1] ), $_->[2], $_->[0]
    for @tests;
done_testing;
