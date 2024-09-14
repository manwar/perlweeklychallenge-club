#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 286 Task 2: Order Game
#
#       Perl solution by Matthias Muth.
#

use v5.36;
use List::Util qw( pairs min max );
use builtin 'indexed';
no warnings 'experimental::builtin';

# Using map to avoid temporary array.
# Enumerate pairs, use [ index, pair ref ] for map loop.
sub order_game( @ints ) {
    while ( @ints > 1 ) {
        @ints = map {
            my ( $index, $pair ) = $_->@*;
            $index % 2 == 0
            ? min( $pair->@* )
            : max( $pair->@* );
        } pairs indexed pairs @ints;
    }
    return $ints[0];
}


use Test2::V0 qw( -no_srand );
is order_game( 2, 1, 4, 5, 6, 3, 0, 2 ), 1,
    'Example 1: order_game( 2, 1, 4, 5, 6, 3, 0, 2 ) == 1';
is order_game( 0, 5, 3, 2 ), 0,
    'Example 2: order_game( 0, 5, 3, 2 ) == 0';
is order_game( 9, 2, 1, 4, 5, 6, 0, 7, 3, 1, 3, 5, 7, 9, 0, 8 ), 2,
    'Example 3: order_game( 9, 2, 1, 4, 5, 6, 0, 7, 3, 1, 3, 5, 7, 9, 0, 8 ) == 2';
done_testing;
