#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 391 Task 1: Array Median
#
#       Perl solution by Matthias Muth.
#

use v5.36;

sub array_median( $arr1, $arr2 ) {
    my @all = sort { $a <=> $b } ( $arr1->@*, $arr2->@* );
    return @all % 2 == 0
        ? ( $all[ @all / 2 - 1 ] + $all[ @all / 2 ] ) / 2
        : $all[ int( @all / 2 ) ];
}

use Test2::V0 qw( -no_srand );

my @tests = (
    [ "Example 1", [[2], [4]], 3 ],
    [ "Example 2", [[1, 2, 3], [7 .. 10]], 7 ],
    [ "Example 3", [[], [10, 20, 30, 40]], 25 ],
    [ "Example 4", [[100], [1 .. 7]], 4.5 ],
    [ "Example 5", [[1, 2, 2], [2, 2, 3]], 2 ],
);

is array_median( $_->[1]->@* ), $_->[2], $_->[0]
    for @tests;

done_testing;
