#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 335 Task 2: Find Winner
#
#       Perl solution by Matthias Muth.
#

use v5.36;

# winning lines:
#    0 - . . .
#    1 - . . .
#    2 - . . .
#       /| | |\
#     7  3 4 5  6

my @lines_by_points = (
    [ [ 0, 3, 6 ], [ 0, 4 ],       [ 0, 5, 7 ] ],
    [ [ 1, 3    ], [ 1, 4, 6, 7 ], [ 1, 5 ]    ],
    [ [ 2, 3, 7 ], [ 2, 4 ],       [ 2, 5, 6 ] ],
);

sub find_winner( $moves ) {
    my @lines;
    my $player = "A";
    for ( $moves->@* ) {
        my ( $r, $c ) = $_->@[0,1];
        for my $line ( $lines_by_points[$r][$c]->@* ) {
            return $player
                if ++$lines[$line]{$player} == 3;
        }
        $player = $player eq "A" ? "B" : "A";
    }
    return $moves->@* == 9 ? "Draw" : "Pending";
}

use Test2::V0 qw( -no_srand );

is find_winner( [[0, 0], [2, 0], [1, 1], [2, 1], [2, 2]] ), "A",
    'Example 1: find_winner( [[0, 0], [2, 0], [1, 1], [2, 1], [2, 2]] ) == "A"';
is find_winner( [[0, 0], [1, 1], [0, 1], [0, 2], [1, 0], [2, 0]] ), "B",
    'Example 2: find_winner( [[0, 0], [1, 1], [0, 1], [0, 2], [1, 0], [2, 0]] ) == "B"';
is find_winner( [ [0, 0], [1, 1], [2, 0], [1, 0], [1, 2], [2, 1], [0, 1], [0, 2], [2, 2], ] ), "Draw",
    'Example 3: find_winner( [ [0, 0], [1, 1], [2, 0], [1, 0], [1, 2], [2, 1], [0, 1], [0, 2], [2, 2], ] ) == "Draw"';
is find_winner( [[0, 0], [1, 1]] ), "Pending",
    'Example 4: find_winner( [[0, 0], [1, 1]] ) == "Pending"';
is find_winner( [[1, 1], [0, 0], [2, 2], [0, 1], [1, 0], [0, 2]] ), "B",
    'Example 5: find_winner( [[1, 1], [0, 0], [2, 2], [0, 1], [1, 0], [0, 2]] ) == "B"';

done_testing;
