#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 345 Task 2: Last Visitor
#
#       Perl solution by Matthias Muth.
#

use v5.36;

sub last_visitor( @ints ) {
    my ( $count, @seen );
    return map {
        $_ == -1
        ? $seen[$count++] // -1
        : do { unshift @seen, $_; $count = 0; () }
    } @ints;
}

use Test2::V0 qw( -no_srand );

is [ last_visitor( 5, -1, -1 ) ], [ 5, -1 ],
    'Example 1: last_visitor( 5, -1, -1 ) == (5, -1)';
is [ last_visitor( 3, 7, -1, -1, -1 ) ], [ 7, 3, -1 ],
    'Example 2: last_visitor( 3, 7, -1, -1, -1 ) == (7, 3, -1)';
is [ last_visitor( 2, -1, 4, -1, -1 ) ], [ 2, 4, 2 ],
    'Example 3: last_visitor( 2, -1, 4, -1, -1 ) == (2, 4, 2)';
is [ last_visitor( 10, 20, -1, 30, -1, -1 ) ], [ 20, 30, 20 ],
    'Example 4: last_visitor( 10, 20, -1, 30, -1, -1 ) == (20, 30, 20)';
is [ last_visitor( -1, -1, 5, -1 ) ], [ -1, -1, 5 ],
    'Example 5: last_visitor( -1, -1, 5, -1 ) == (-1, -1, 5)';

done_testing;
