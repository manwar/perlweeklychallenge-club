#!/usr/bin/perl
use strict;
use warnings;
#-------------------------------------------

sub is_x_matrix_packy {
    my $matrix = shift;

    my $size = @$matrix;

    for my $i (0 .. $size - 1) {
        for my $j (0 .. $size - 1) {
            if ($i == $j || $i + $j == $size - 1) {
                # it's a diagonal
                return 0 if $matrix->[$i][$j] == 0;
             }
             else {
                 # it's NOT a diagonal
                 return 0 if $matrix->[$i][$j] != 0;
             } # if
        } # for $j
     } # for $i

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
print(is_x_matrix_packy($matrix), "\n"); # Output: 1 (= TRUE)

# Example 2
$matrix = [ [1, 2, 3],
            [4, 5, 6],
            [7, 8, 9],
          ];
print(is_x_matrix_packy($matrix), "\n"); # Output: 0 (= FALSE)

# Example 3
$matrix = [ [1, 0, 2],
            [0, 3, 0],
            [4, 0, 5],
          ];
print(is_x_matrix_packy($matrix), "\n"); # Output: 1 (= TRUE)
