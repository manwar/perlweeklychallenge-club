#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-376/#TASK1
#
# Task 1: Chessboard Squares
# ==========================
#
# You are given two coordinates of a square on 8x8 chessboard.
#
# Write a script to find the given two coordinates have the same colour.
#
# 8 W B W B W B W B
# 7 B W B W B W B W
# 6 W B W B W B W B
# 5 B W B W B W B W
# 4 W B W B W B W B
# 3 B W B W B W B W
# 2 W B W B W B W B
# 1 B W B W B W B W
#   a b c d e f g h
#
## Example 1
##
## Input: $c1 = "a7", $c2 = "f4"
## Output: true
#
## Example 2
##
## Input: $c1 = "c1", $c2 = "e8"
## Output: false
#
## Example 3
##
## Input: $c1 = "b5", $c2 = "h2"
## Output: false
#
## Example 4
##
## Input: $c1 = "f3", $c2 = "h1"
## Output: true
#
## Example 5
##
## Input: $c1 = "a1", $c2 = "g8"
## Output: false
#
############################################################
##
## discussion
##
############################################################
#
# We translate a through h to numbers in the range 1 through 8.
# Then two coordinates have the same color if the sum of their
# coordinates share the same parity.

use v5.36;

chessboard_squares("a7", "f4");
chessboard_squares("c1", "e8");
chessboard_squares("b5", "h2");
chessboard_squares("f3", "h1");
chessboard_squares("a1", "g8");

sub chessboard_squares($c1, $c2) {
    say "Input: c1 = $c1, c2 = $c2";
    my ($column1, $row1) = split //, $c1;
    my ($column2, $row2) = split //, $c2;
    my $column_to_number = {
        "a" => 1, "b" => 2, "c" => 3, "d" => 4,
        "e" => 5, "f" => 6, "g" => 7, "h" => 8
    };
    if ( ($column_to_number->{$column1} + $row1) % 2
        == ($column_to_number->{$column2} + $row2) % 2) {
        say "Output: true";
    } else {
        say "Output: false";
    }
}
