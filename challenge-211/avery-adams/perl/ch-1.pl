#!/bin/perl

use strict;
use v5.28;

my @matrix1 = (
    [4, 3, 2, 1],
    [5, 4, 3, 2],
    [6, 5, 4, 3],
);

my @matrix2 = ([1, 2, 3], [3, 2, 1]);

say 'Is Matrix1 a Toeplitz matrix? : ' . (is_toeplitz(@matrix1) ? 'TRUE' : 'FALSE');
say 'Is Matrix2 a Toeplitz matrix? : ' . (is_toeplitz(@matrix2) ? 'TRUE' : 'FALSE');

sub is_toeplitz {
    my @matrix = @_;

    my $rows = scalar @matrix;
    my $cols = scalar @{$matrix[0]};

    for (my $r = 1; $r < $rows; $r++) {
        for (my $c = 1; $c < $cols; $c++) {
            if ($matrix[$r][$c] != $matrix[$r - 1][$c - 1]) {return 0;}
        }
    }
    return 1;
}
