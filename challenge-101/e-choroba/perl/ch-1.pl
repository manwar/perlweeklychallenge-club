#!/usr/bin/perl
use warnings;
use strict;

my @DIRECTIONS = ([1, 0], [0, -1], [-1, 0], [0, 1]);
sub pack_spiral {
    my (@arr) = @_;

    my $w = int sqrt @arr;
    $w++ while @arr % $w;
    my $h = @arr / $w;

    my @spiral = map [], 1 .. $h;
    my $direction = 0;
    my ($x, $y) = (0, $h - 1);

    my @borders = ($h - 1, $w - 1, 0, 0);
    my $turned;
    for my $element (@arr) {
        $spiral[$y][$x] = $element;

        my $new_x = $x + $DIRECTIONS[$direction][0];
        my $new_y = $y + $DIRECTIONS[$direction][1];
        if ($new_x < $borders[3] || $new_x > $borders[1]
            || $new_y < $borders[2] || $new_y > $borders[0]
        ) {
            last if $turned;

            $borders[$direction] += (-1, -1, 1, 1)[$direction];
            $direction = ($direction + 1) % 4;
            $turned = 1;
            redo
        }
        undef $turned;
        ($x, $y) = ($new_x, $new_y);
    }
    return \@spiral
}

use Test::More tests => 6;

is_deeply pack_spiral(1 .. 4),
    [[4, 3],
     [1, 2]],
    'Example 1';

is_deeply pack_spiral(1 .. 6),
    [[5, 4],
     [6, 3],
     [1, 2]],
    'Example 2';

is_deeply pack_spiral(1 .. 12),
    [[ 8,  7, 6],
     [ 9, 12, 5],
     [10, 11, 4],
     [ 1,  2, 3]],
    'Example 3';

is_deeply pack_spiral(11 .. 30),
    [[21, 20, 19, 18],
     [22, 29, 28, 17],
     [23, 30, 27, 16],
     [24, 25, 26, 15],
     [11, 12, 13, 14]],
    '20=4x5';

is_deeply pack_spiral(10 .. 49),
    [[28, 27, 26, 25, 24, 23, 22, 21],
     [29, 44, 43, 42, 41, 40, 39, 20],
     [30, 45, 46, 47, 48, 49, 38, 19],
     [31, 32, 33, 34, 35, 36, 37, 18],
     [10, 11, 12, 13, 14, 15, 16, 17]],
    '40=8x5';

is_deeply pack_spiral(10 .. 36),
    [[28, 27, 26, 25, 24, 23, 22, 21, 20],
     [29, 30, 31, 32, 33, 34, 35, 36, 19],
     [10, 11, 12, 13, 14, 15, 16, 17, 18]],
    '27=9x3';
