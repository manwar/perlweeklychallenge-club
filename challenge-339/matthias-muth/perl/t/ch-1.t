#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 339 Task 1: Max Diff
#
#       t/ch-1.t - test script for ch-1.pl.
#

use v5.36;

use lib qw( . .. );
require "./ch-1.pl";

use Test2::V0 qw( -no_srand );

my @tests = (
    [ "Test 0", [ +5, +4, +3, +2 ], 14 ],
    [ "Test 1", [ -5, +4, +3, +2 ], 26 ],
    [ "Test 2", [ +5, -4, +3, +2 ], 26 ],
    [ "Test 3", [ -5, -4, +3, +2 ], 14 ],
    [ "Test 4", [ +5, +4, -3, +2 ], 26 ],
    [ "Test 5", [ -5, +4, -3, +2 ], 14 ],
    [ "Test 6", [ +5, -4, -3, +2 ], 14 ],
    [ "Test 7", [ -5, -4, -3, +2 ], 26 ],
    [ "Test 8", [ +5, +4, +3, -2 ], 26 ],
    [ "Test 9", [ -5, +4, +3, -2 ], 14 ],
    [ "Test 10", [ +5, -4, +3, -2 ], 14 ],
    [ "Test 11", [ -5, -4, +3, -2 ], 26 ],
    [ "Test 12", [ +5, +4, -3, -2 ], 14 ],
    [ "Test 13", [ -5, +4, -3, -2 ], 26 ],
    [ "Test 14", [ +5, -4, -3, -2 ], 26 ],
    [ "Test 15", [ -5, -4, -3, -2 ], 14 ],

    [ "Test 16 (201 numbers)", [ -100..+100 ], 19702 ],

    [ "Example 1", [ 5, 9, 3, 4, 6 ], 42 ],
    [ "Example 2", [ 1, -2, 3, -4 ], 10 ],
    [ "Example 3", [ -3, -1, -2, -4 ], 10 ],
    [ "Example 4", [ 10, 2, 0, 5, 1 ], 50 ],
    [ "Example 5", [ 7, 8, 9, 10, 10 ], 44 ],
);

for ( @tests ) {
    my ( $test_name, $input, $expected ) = $_->@*;
    my $descr = "$test_name:"
        . " max_diff( " . join( ", ", $input->@* ) . " ) == $expected";
    is max_diff( $input->@* ), $expected, $descr;
}

done_testing;
