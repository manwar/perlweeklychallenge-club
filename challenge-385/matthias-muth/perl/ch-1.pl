#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 385 Task 1: Uncommon Words
#
#       Perl solution by Matthias Muth.
#

use v5.36;
use List::MoreUtils qw( frequency );

sub uncommon_words( $sentence1, $sentence2 ) {
    my %freq = frequency map { split " " } $sentence1, $sentence2;
    return grep { $freq{$_} == 1 } keys %freq;
}

use Test2::V0 qw( -no_srand );

my @tests = (
    [ "Example 1", ["apple banana apple", "banana orange"],
        ["orange"] ],
    [ "Example 2", ["cat dog", "bird fish"],
        bag { item $_ for "cat", "dog", "bird", "fish"; end } ],
    [ "Example 3", ["the quick brown fox", "the quick"],
        bag { item $_ for "brown", "fox"; end } ],
    [ "Example 4", ["hello", "hello"],
        [] ],
    [ "Example 5", ["blue blue red", "red green green yellow"],
        ["yellow"] ],
);

is [ uncommon_words( $_->[1]->@* ) ], $_->[2], $_->[0]
    for @tests;

done_testing;
