#!/usr/bin/env perl

use v5.36;
use Data::Dumper;

say "challenge-211-task1";

# Task 1: Toeplitz Matrix
# You are given a matrix m x n
# Write a script to find out if the given matrix is Toeplitz Matrix

my $matrix = [ 
    [4, 3, 2, 1],
    [5, 4, 3, 2],
    [6, 5, 4, 3],
];

# my $matrix = [
#     [1, 2, 3],
#     [3, 2, 1],
# ];

say Dumper($matrix);

my $rows = @$matrix;
my $cols = @{$matrix->[0]};
my $is_toeplitz = 1;

ROW:
for my $row (0..$rows-2) {
    for my $col (0..$cols-2) {
        say $$matrix[$row][$col], " ", $$matrix[$row+1][$col+1];
        unless ($$matrix[$row][$col] == $$matrix[$row+1][$col+1]) {
            $is_toeplitz = 0;
            last ROW;
        }
    }
}

say $is_toeplitz ? "Toeplitz Matrix!" : "Not Toeplitz Matrix";

