#!/usr/bin/perl
use strict;
use warnings;

sub is_x_matrix {
    my $matrix = shift;
    my $size = @$matrix;

    for (my $i = 0; $i < $size; $i++) {
        for (my $j = 0; $j < $size; $j++) {
            if ($i == $j || $i + $j == $size - 1) {
                return 0 unless $matrix->[$i]->[$j];
            } else {
                return 0 if $matrix->[$i]->[$j];
            }
        }
    }
    return 1;
}

# Test 1
my $matrix1 = [
    [1, 0, 0, 2],
    [0, 3, 4, 0],
    [0, 5, 6, 0],
    [7, 0, 0, 1],
];

print is_x_matrix($matrix1) ? "true\n" : "false\n";  # Output: true

# Test 2
my $matrix2 = [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9],
];

print is_x_matrix($matrix2) ? "true\n" : "false\n";  # Output: false

# Test 3
my $matrix3 = [
    [1, 0, 2],
    [0, 3, 0],
    [4, 0, 5],
];

print is_x_matrix($matrix3) ? "true\n" : "false\n";  # Output: true