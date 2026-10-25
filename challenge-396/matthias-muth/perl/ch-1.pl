#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 396 Task 1: Finishing Order
#
#       Perl solution by Matthias Muth.
#

use v5.36;

sub finishing_order( $order, $friends ) {
    # Set up a lookup array for friends.
    # As the friends' ids are 1 to n only, we can use an array
    # rather than a hash (the entry at index 0 will never be used).
    my @is_friend;
    @is_friend[ $friends->@* ] = ( 1 ) x $friends->@*;

    # Reduce the complete finishing order to friends only,
    # resulting in the list of friends in finishing order.
    return grep $is_friend[$_], $order->@*;
}

use Test2::V0 qw( -no_srand );

my @tests = (
    [ "Example 1", [[3, 1, 4, 2, 5], [1, 2, 4]], [1, 4, 2] ],
    [ "Example 2", [[5, 4, 3, 2, 1], [1, 3, 5]], [5, 3, 1] ],
    [ "Example 3", [[2, 4, 1, 3], [1 .. 4]], [2, 4, 1, 3] ],
    [ "Example 4", [[4, 1, 3, 2], [3]], [3] ],
    [ "Example 5", [[1, 3, 2, 6, 5, 4], [1, 2, 3]], [1, 3, 2] ],
);

is [ finishing_order( $_->[1]->@* ) ], $_->[2], $_->[0]
    for @tests;

done_testing;
