#!/usr/bin/perl
use warnings;
use strict;

my @DIRECTIONS = ([1, 0], [0, 1], [-1, 0], [0, -1]);
sub spiral_matrix {
    my @m = @_;

    my @list;
    my ($x, $y) = (-1, 0);
    my $direction = 0;
    my @border = (scalar @{ $m[0] }, scalar @m, -1, -1);
    my $did_turn;
    while (1) {
        my ($x2, $y2) = ($x + $DIRECTIONS[$direction][0],
                         $y + $DIRECTIONS[$direction][1]);
        if (   $x2 == $border[0] || $x2 == $border[2]
            || $y2 == $border[1] || $y2 == $border[3]
        ) {
            last if $did_turn;

            $border[($direction + 3) % 4] = ($x, $y)[($direction + 1) % 2];
            ++$direction;
            $direction %= 4;
            $did_turn = 1;

        } else {
            undef $did_turn;
            push @list, $m[$y = $y2][$x = $x2];
        }
    }
    return \@list
}

use Test::More;

is_deeply spiral_matrix(
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9]
), [1, 2, 3, 6, 9, 8, 7, 4, 5], 'Example 1';

is_deeply spiral_matrix(
    [ 1,  2,  3,  4],
    [ 5,  6,  7,  8],
    [ 9, 10, 11, 12],
    [13, 14, 15, 16]
), [1, 2, 3, 4, 8, 12, 16, 15, 14, 13, 9, 5, 6, 7, 11, 10], 'Example 2';

is_deeply spiral_matrix(
    [ 1,  2,  3,  4,  5],
    [12, 13, 14, 15,  6],
    [11, 10,  9,  8,  7]
), [1 .. 15], 'm != n';

is_deeply spiral_matrix([1]), [1], 'minimal';
is_deeply spiral_matrix([1], [2]), [1, 2], 'two lines';
is_deeply spiral_matrix([1, 2], [4, 3]), [1 .. 4], '2x2';
is_deeply spiral_matrix([1, 2, 3], [8, 9, 4], [7, 6, 5]), [1 .. 9], '3x3';
is_deeply spiral_matrix([1, 2], [6, 3], [5, 4]), [1 .. 6], 'narrow';

is_deeply spiral_matrix(
    [ 1,  2,  3,  4,  5,  6],
    [20, 21, 22, 23, 24,  7],
    [19, 32, 33, 34, 25,  8],
    [18, 31, 36, 35, 26,  9],
    [17, 30, 29, 28, 27, 10],
    [16, 15, 14, 13, 12, 11],
), [1 .. 36], '6x6';

is_deeply spiral_matrix(
    [ 1,  2,  3,  4,  5,  6,  7,  8,  9],
    [36, 37, 38, 39, 40, 41, 42, 43, 10],
    [35, 64, 65, 66, 67, 68, 69, 44, 11],
    [34, 63, 84, 85, 86, 87, 70, 45, 12],
    [33, 62, 83, 96, 97, 88, 71, 46, 13],
    [32, 61, 82, 95, 98, 89, 72, 47, 14],
    [31, 60, 81, 94, 99, 90, 73, 48, 15],
    [30, 59, 80, 93, 92, 91, 74, 49, 16],
    [29, 58, 79, 78, 77, 76, 75, 50, 17],
    [28, 57, 56, 55, 54, 53, 52, 51, 18],
    [27, 26, 25, 24, 23, 22, 21, 20, 19],
), [1 .. 99], '9x11';

done_testing();
