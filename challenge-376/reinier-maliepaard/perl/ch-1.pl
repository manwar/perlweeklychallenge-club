#!/usr/bin/perl
use strict;
use warnings;

# Background
# Return the parity of a square:
# 0 = black square
# 1 = white square
#
# Chess notation uses:
#   file = column (a-h)
#   rank = row    (1-8)
#
# Examples:
#   a1 -> 0 (black)
#   h1 -> 1 (white)
#   a8 -> 1 (white)
#   h8 -> 0 (black)
#
# So, parity is just the checkerboard pattern encoded as 0/1.
# In other words: a compact way to represent the alternating
# pattern of the chessboard.
#
# Example e4:
#
# Code: ((ord($file) - ord('a')) + ($rank - 1)) % 2;
# Convert file letter to number: $file = 'e'
#                                      -> ord('e') - ord('a') = 101 - 97 = 4
# Convert rank to 0-based index: $rank = 4
#                                      -> 4 - 1 = 3
# 4 + 3 = 7
# 7 % 2 = 1
# Result: e4 -> parity = 1 (white)

# Notes on solution:
# Two subroutines are used to separate concerns:
# square_parity() handles the low-level computation of a square's color parity (0/1)
# chessboard_squares() expresses a higher-level chess rule by comparing two parities.
#
# Advantage:
# - clearer code (intent vs implementation)
# - reuse of the core logic without duplication
# - easier maintenance (changes in parity logic only affect one place)

sub square_parity {
    my ($square) = @_;

    my ($file, $rank) = $square =~ /^([a-h])([1-8])$/
        or die "Invalid square: $square\n";

    return ((ord($file) - ord('a')) + ($rank - 1)) % 2;
}

sub chessboard_squares {
    my ($sq1, $sq2) = @_;
    return square_parity($sq1) == square_parity($sq2) ? "true" : "false";
}

# TESTS

my ($c1, $c2);

# Example 1
$c1 = "a7";
$c2 = "f4";
print chessboard_squares($c1, $c2), "\n"; # Output: true

# Example 2
$c1 = "c1";
$c2 = "e8";
print chessboard_squares($c1, $c2), "\n"; # Output: false

# Example 3
$c1 = "b5";
$c2 = "h2";
print chessboard_squares($c1, $c2), "\n"; # Output: false

# Example 4
$c1 = "f3";
$c2 = "h1";
print chessboard_squares($c1, $c2), "\n"; # Output: true

# Example 5
$c1 = "a1";
$c2 = "g8";
print chessboard_squares($c1, $c2), "\n"; # Output: false
