#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 390 Task 2: Order Characters
#
#       Perl solution by Matthias Muth.
#

use v5.36;

use List::Util qw( minstr );

sub order_characters( $str, $k ) {
    # For $k >= 2, we know we can always sort the letters completely,
    # so let's shortcut that.
    # For k == 1, we can only rotate the string character by character.
    # We then return the lexicographically smallest of all rotated strings.
    return
        $k >= 2
        ?  join "", sort split "", $str
        : minstr( map substr( $str, $_ ) . substr( $str, 0, $_ ),
            0 .. length( $str ) - 1 );
}

use Test2::V0 qw( -no_srand );

my @tests = (
    [ "Example 1", ["dbca", 1], "adbc" ],
    [ "Example 2", ["geeks", 2], "eegks" ],
    [ "Example 3", ["cbaed", 3], "abcde" ],
    [ "Example 4", ["fedcba", 4], "abcdef" ],
    [ "Example 5", ["perl", 1], "erlp" ],
    [ "Example 6", ["oloolooo", 1], "looloooo" ],
    [ "Example 7", ["oloooolo", 1], "looloooo" ],
);

is order_characters( $_->[1]->@* ), $_->[2], $_->[0]
    for @tests;

done_testing;
