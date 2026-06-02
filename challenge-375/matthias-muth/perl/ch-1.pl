#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 375 Task 1: Single Common Word
#
#       Perl solution by Matthias Muth.
#

use v5.36;

use List::MoreUtils qw( frequency );

sub single_common_word( $array1, $array2 ) {
    my %freq1 = frequency $array1->@*;
    my %freq2 = frequency $array2->@*;
    return scalar grep { $freq1{$_} == 1 == ( $freq2{$_} // 0 ) } keys %freq1;
}

use Test2::V0 qw( -no_srand );

my @tests = (
    [ "Example 1",
        [["apple", "banana", "cherry"], ["banana", "cherry", "date"]],
        2 ],
    [ "Example 2", [["a", "ab", "abc"], ["a", "a", "ab", "abc"]], 2 ],
    [ "Example 3", [["orange", "lemon"], ["grape", "melon"]], 0 ],
    [ "Example 4", [["test", "test", "demo"], ["test", "demo", "demo"]], 0 ],
    [ "Example 5", [["Hello", "world"], ["hello", "world"]], 1 ],
);

is single_common_word( $_->[1]->@* ), $_->[2], $_->[0]
    for @tests;
done_testing;
