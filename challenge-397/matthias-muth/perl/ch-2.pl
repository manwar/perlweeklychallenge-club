#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 397 Task 2: Binary Reflection
#
#       Perl solution by Matthias Muth.
#

use v5.36;

sub reflected( $n ) {
    return oct "0b" . reverse sprintf( "%b", $n );
}

sub binary_reflection( @arr ) {
    # Using a Schwartzian Transform.
    return map $_->[0],
        sort { $a->[1] <=> $b->[1] || $a->[0] <=> $b->[0] }
            map [ $_, reflected $_ ],
                @arr;
}

use Test2::V0 qw( -no_srand );

my @tests = (
    [ "Example 1", [3, 6, 12], [3, 6, 12] ],
    [ "Example 2", [1, 2, 4, 8], [1, 2, 4, 8] ],
    [ "Example 3", [7 .. 10], [8, 10, 7, 9] ],
    [ "Example 4", [5, 9, 15, 17], [5, 9, 15, 17] ],
    [ "Example 5", [11, 13, 14, 19], [14, 13, 11, 19] ],
);

is [ binary_reflection( $_->[1]->@* ) ], $_->[2], $_->[0]
    for @tests;

done_testing;
