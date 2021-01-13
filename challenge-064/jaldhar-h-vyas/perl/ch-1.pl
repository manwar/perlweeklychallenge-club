#!/usr/bin/perl
use warnings;
use strict;
use 5.010;

my $matrix = [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9],
];

my $bottom_edge = scalar @{$matrix} - 1;
my $right_edge = scalar @{$matrix->[0]} - 1;  # assuming matrix is square
my $row = 0;
my $col = 0;
my $total = $matrix->[0]->[0];
my @path;
push @path, $matrix->[0]->[0];

while ($row < $bottom_edge || $col < $right_edge) {

    my $down = 1_000_000;
    if ($row + 1 <= $bottom_edge) {
        $down = $total + $matrix->[$row + 1]->[$col];
    }

    my $right = 1_000_000;
    if ($col + 1 <= $right_edge) {
        $right = $total + $matrix->[$row]->[$col + 1];
    }

    if ($down < $right) {
        $row++;
        $total = $down;
    } else {
        $col++;
        $total = $right;
    }
    push @path, $matrix->[$row]->[$col];
}

say join ' -> ', @path;
