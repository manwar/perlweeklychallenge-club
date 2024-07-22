#!/usr/bin/perl

# https://theweeklychallenge.org/blog/perl-weekly-challenge-279/
# TASK #1 > Sort Letters
#
# You are given two arrays, @letters and @weights.
#
# Write a script to sort the given array @letters based on the @weights.

use strict;
use warnings;
use Test2::V0 '-no_srand';

my @tests = (
    [ ['R', 'E', 'P', 'L'], [3, 2, 1, 4], 'PERL' ],
    [ ['A', 'U', 'R', 'K'], [2, 4, 1, 3], 'RAKU' ],
    [ ['O', 'H', 'Y', 'N', 'P', 'T'], [5, 4, 2, 6, 1, 3], 'PYTHON' ],
);

for my $test (@tests) {
    my ($letters, $weights, $expected) = @$test;
    is sorted_by_weight($letters, $weights), $expected;
}

done_testing;

sub sorted_by_weight {
    my ($letters, $weights) = @_;
    my @order = sort { $weights->[$a] <=> $weights->[$b] } 0 .. $#{$letters};
    return $letters->@[@order];
}
