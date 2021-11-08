#!/usr/bin/perl

# https://theweeklychallenge.org/blog/perl-weekly-challenge-126/
# Task #2
#
# Minesweeper Game
# You are given a rectangle with points marked with either x or *. Please consider the x as a land mine.
#
# Write a script to print a rectangle with numbers and x as in the Minesweeper game.
#
# A number in a square of the minesweeper game indicates the number of mines within the neighbouring squares (usually 8), also implies that there are no bombs on that square.
#
# Example
# Input:
#     x * * * x * x x x x
#     * * * * * * * * * x
#     * * * * x * x * x *
#     * * * x x * * * * *
#     x * * * x * * * * x
#
# Output:
#     x 1 0 1 x 2 x x x x
#     1 1 0 2 2 4 3 5 5 x
#     0 0 1 3 x 3 x 2 x 2
#     1 1 1 x x 4 1 2 2 2
#     x 1 1 3 x 2 0 0 1 x

use strict;
use warnings;
use feature qw(postderef);

my $rows = [
    [qw/x * * * x * x x x x/],
    [qw/* * * * * * * * * x/],
    [qw/* * * * x * x * x */],
    [qw/* * * x x * * * * */],
    [qw/x * * * x * * * * x/]
];

my $max_row = $rows->@* - 1;
my $max_col = $rows->[0]->@* - 1;

for my $r (0 .. $max_row) {
    for my $c (0 .. $max_col) {
        my $output = $rows->[$r]->[$c];
        if ($output eq '*') {
            $output = 0;
            for (-1,0,1) {
                my $x = $r + $_;
                next if $x < 0 || $x > $max_row;
                for (-1,0,1) {
                    my $y = $c + $_;
                    next if $y < 0 || $y > $max_col;
                    $output++ if $rows->[$x]->[$y] eq 'x';
                }
            }

        }
        print $output,' ';
    }
    print "\n";
}
