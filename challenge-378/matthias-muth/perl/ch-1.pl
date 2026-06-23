#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 378 Task 1: Second Largest Digit
#
#       Perl solution by Matthias Muth.
#

use v5.36;
use List::Util qw( uniq );

sub second_largest_digit( $str ) {
    my @sorted_digits = sort { $b <=> $a } uniq $str =~ /\d/g;
    return $sorted_digits[1] // -1;
}

use Test2::V0 qw( -no_srand );

my @tests = (
    [ "Example 1", "aaaaa77777", -1 ],
    [ "Example 2", "abcde", -1 ],
    [ "Example 3", "9zero8eight7seven9", 8 ],
    [ "Example 4", "xyz9876543210", 8 ],
    [ "Example 5", "4abc4def2ghi8jkl2", 4 ],
    [ "Own Test 1", "01", 0 ],
);

is second_largest_digit( $_->[1] ), $_->[2], $_->[0]
    for @tests;
done_testing;
