#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 339 Task 1: Max Diff
#
#       test-ch-1.pl - test script for ch-1.pl.
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
    my ( $maximum, $pair_1, $pair_2 ) = max_diff( $input->@* );
    is $maximum, $expected, $descr
        and $pair_1 && $pair_2 && do {
            # Explain the correct solution.
            my $product_1 = $pair_1->[0] * $pair_1->[1];
            my $product_2 = $pair_2->[0] * $pair_2->[1];
            my $result = $product_1 - $product_2;
            note "            Pair 1: ( $pair_1->[0], $pair_1->[1] )";
            note "            Pair 2: ( $pair_2->[0], $pair_2->[1] )";
            note "            Product Diff: ",
                "( $pair_1->[0] * $pair_1->[1] )",
                    " - ( $pair_2->[0] * $pair_2->[1] )",
                " => ( ", $product_1 >= 0 ? $product_1 : "($product_1)",
                    " - ", $product_2 >= 0 ? $product_2 : "($product_2)", " )",
                " => $result";
            note "";
        }
}

done_testing;
