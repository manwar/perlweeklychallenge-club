#!/usr/bin/perl
use strict;
use warnings;
#-------------------------------------------

sub is_x_matrix {
    my $matrix = shift;

    my $size = @$matrix;

    # check main diagonal and antidiagonal
    for my $i (0 .. $size - 1) {
        # check main diagonal
        return 0 if ($matrix->[$i][$i] == 0);
        # check antidiagonal
        return 0 if ($matrix->[$i][$size - 1 - $i] == 0);
    }

    # check all other elements
    for my $i (0 .. $size - 1) {
        for my $j (0 .. $size - 1) {
            return 0 if ($i != $j && $i + $j != ($size - 1) && $matrix->[$i][$j] != 0);
        }
    }

    # it's an X Matrix
    return 1;
}

# TESTS

my $matrix;

# Example 1
$matrix = [ [1, 0, 0, 2],
            [0, 3, 4, 0],
            [0, 5, 6, 0],
            [7, 0, 0, 1],
          ];
print(is_x_matrix($matrix), "\n"); # Output: 1

# Example 2
$matrix = [ [1, 2, 3],
            [4, 5, 6],
            [7, 8, 9],
          ];
print(is_x_matrix($matrix), "\n"); # Output: 0

# Example 3
$matrix = [ [1, 0, 2],
            [0, 3, 0],
            [4, 0, 5],
          ];
print(is_x_matrix($matrix), "\n"); # Output: 1
