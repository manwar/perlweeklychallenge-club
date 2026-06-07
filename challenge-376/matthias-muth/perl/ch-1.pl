#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 376 Task 1: Chessboard Squares
#
#       Perl solution by Matthias Muth.
#

use v5.36;

sub chessboard_squares( $c1, $c2 ) {
    my $dist = 0;
    $dist ^= ord( $_ )
        for split "", "$c1$c2";
    return ( $dist & 0x01 ) == 0;
}

use Test2::V0 qw( -no_srand );

my @tests = (
    [ "Example 1", ["a7", "f4"], T ],
    [ "Example 2", ["c1", "e8"], F ],
    [ "Example 3", ["b5", "h2"], F ],
    [ "Example 4", ["f3", "h1"], T ],
    [ "Example 5", ["a1", "g8"], F ],
);

is chessboard_squares( $_->[1]->@* ), $_->[2], $_->[0]
    for @tests;
done_testing;
