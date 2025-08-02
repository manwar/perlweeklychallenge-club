#!/usr/bin/env perl
#
=head1 Task 2: X Matrix

You are given a square matrix, $matrix.

Write a script to find if the given matrix is X Matrix.

	A square matrix is an X Matrix if all the elements on the main diagonal and
	antidiagonal are non-zero and everything else are zero.

=head2 Example 1

Input: $matrix = [ [1, 0, 0, 2],
                   [0, 3, 4, 0],
                   [0, 5, 6, 0],
                   [7, 0, 0, 1],
                 ]
Output: true

=head2 Example 2

Input: $matrix = [ [1, 2, 3],
                   [4, 5, 6],
                   [7, 8, 9],
                 ]
Output: false

=head2 Example 3

Input: $matrix = [ [1, 0, 2],
                   [0, 3, 0],
                   [4, 0, 5],
                 ]
Output: true

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
    [[[1, 0, 0, 2],
      [0, 3, 4, 0],
      [0, 5, 6, 0],
      [7, 0, 0, 1],
     ], 1, 'Example 1'],
    [[[1, 2, 3],
      [4, 5, 6],
      [7, 8, 9],
     ], 0, 'Example 2'],
    [[[1, 0, 2],
      [0, 3, 0],
      [4, 0, 5],
     ], 1, 'Example 3'],
];

sub x_matrix
{
    my $m = shift;
    my $n = $#$m;

    for my $i (0..$n) {
        for my $j (0..$n) {
            if ($i == $j || ($i+$j) == $n) { # diagional or antidiaginal
                return 0 if $m->[$i]->[$j] == 0;
            } else { # any other
                return 0 if $m->[$i]->[$j] != 0;
            }
        }
    }
    return 1;
}

for (@$cases) {
    is(x_matrix($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;

