#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 389 Task 1: Reorder Notes
#
#       Perl solution by Matthias Muth.
#

use v5.36;

sub reorder_notes( $melody ) {
    my @reordered;
    @reordered[ map $_ - 1, $melody->[2]->@* ] = $melody->[1]->@*;
    return uc( $melody->[0] ) . " => @reordered";
}

use Test2::V0 qw( -no_srand );

my @tests = (
    [ "Example 1",
        [ [ "Bach",
            ["C", "D", "E", "F#", "G", "A", "B"],
            [7, 1, 6, 2, 5, 3, 4] ] ],
        "BACH => D F# A B G E C",
    ],
    [ "Example 2",
        [ ["Beethoven", ["C", "D", "F#", "G", "Ab"], [1, 3, 5, 2, 4]] ],
        "BEETHOVEN => C G D Ab F#",
    ],
    [ "Example 3",
        [ [ "Brahms",
            ["C", "Db", "Eb", "F", "G", "Ab", "Bb", "C", "D"],
            [9, 3, 7, 1, 8, 5, 2, 6, 4] ] ],
        "BRAHMS => F Bb Db D Ab C Eb G C",
    ],
    [ "Example 4",
        [ [ "Bruckner",
            ["G", "F#", "Bb", "C", "D", "Eb", "F"],
            [4, 7, 2, 6, 1, 5, 3] ] ],
        "BRUCKNER => D Bb F G Eb C F#",
    ],
    [ "Example 5",
        [ ["Berg", ["C#"], [1]] ],
        "BERG => C#",
    ],
);

run( "reorder_notes", \@tests );
