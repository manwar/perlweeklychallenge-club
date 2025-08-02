#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 268 Task 2: Number Game
#
#       Perl solution by Matthias Muth.
#

use v5.36;

use List::Util qw( pairs );

sub number_game( @ints ) {
    return map { reverse $_->@* } pairs sort { $a <=> $b } @ints;
}

use Test2::V0 qw( -no_srand );
is [ number_game( 2, 5, 3, 4 ) ], [ 3, 2, 5, 4 ],
    'Example 1: number_game( 2, 5, 3, 4 ) == (3, 2, 5, 4)';
is [ number_game( 9, 4, 1, 3, 6, 4, 6, 1 ) ], [ 1, 1, 4, 3, 6, 4, 9, 6 ],
    'Example 2: number_game( 9, 4, 1, 3, 6, 4, 6, 1 ) == (1, 1, 4, 3, 6, 4, 9, 6)';
is [ number_game( 1, 2, 2, 3 ) ], [ 2, 1, 3, 2 ],
    'Example 3: number_game( 1, 2, 2, 3 ) == (2, 1, 3, 2)';
done_testing;
