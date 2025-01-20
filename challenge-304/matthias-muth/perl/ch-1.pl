#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 304 Task 1: Arrange Binary
#
#       Perl solution by Matthias Muth.
#

use v5.36;

sub arrange_binary( $digits, $n ) {
    my $string = join "", $digits->@*;
    while ( $string =~ s/ (?<!1) 0 (?!1) /1/x ) {
	--$n;
    }
    return $n <= 0;
}

use Test2::V0 qw( -no_srand );

is arrange_binary( [1, 0, 0, 0, 1], 1 ), T,
    'Example 1: arrange_binary( [1, 0, 0, 0, 1], 1 ) is true';
is arrange_binary( [1, 0, 0, 0, 1], 2 ), F,
    'Example 2: arrange_binary( [1, 0, 0, 0, 1], 2 ) is false';
is arrange_binary( [], 0 ), T,
    'Test 1: arrange_binary( [], 0 ) is true';
is arrange_binary( [], 1 ), F,
    'Test 2: arrange_binary( [], 1 ) is false';
is arrange_binary( [ 0 ], 1 ), T,
    'Test 3: arrange_binary( [ 0 ], 1 ) is true';
is arrange_binary( [ 1 ], 1 ), F,
    'Test 4: arrange_binary( [ 1 ], 1 ) is false';
is arrange_binary( [ 0 ], 2 ), F,
    'Test 5: arrange_binary( [ 0 ], 2 ) is false';
is arrange_binary( [0, 0], 1 ), T,
    'Test 6: arrange_binary( [0, 0], 1 ) is true';
is arrange_binary( [0, 0], 2 ), F,
    'Test 7: arrange_binary( [0, 0], 2 ) is false';
is arrange_binary( [0, 1], 1 ), F,
    'Test 8: arrange_binary( [0, 1], 1 ) is false';
is arrange_binary( [0, 0, 0], 2 ), T,
    'Test 9: arrange_binary( [0, 0, 0], 2 ) is true';
is arrange_binary( [1, 0, 0], 1 ), T,
    'Test 10: arrange_binary( [1, 0, 0], 1 ) is true';
is arrange_binary( [0, 1, 0], 1 ), F,
    'Test 11: arrange_binary( [0, 1, 0], 1 ) is false';
is arrange_binary( [0, 0, 1], 1 ), T,
    'Test 12: arrange_binary( [0, 0, 1], 1 ) is true';
is arrange_binary( [0, 0, 0, 0, 0, 0], 3 ), T,
    'Test 13: arrange_binary( [0, 0, 0, 0, 0], 3 ) is true';
is arrange_binary( [0, 0, 0, 0, 0, 0], 4 ), F,
    'Test 14: arrange_binary( [0, 0, 0, 0, 0], 4 ) is false';

done_testing;
