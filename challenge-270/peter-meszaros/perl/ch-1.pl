#!/usr/bin/env perl
#
=head1 Task 1: Special Positions

You are given a m x n binary matrix.

Write a script to return the number of special positions in the given binary matrix.

    A position (i, j) is called special if $matrix[i][j] == 1 and all other
    elements in the row i and column j are 0.

=head2 Example 1

    Input: $matrix = [ [1, 0, 0],
                       [0, 0, 1],
                       [1, 0, 0],
                     ]
    Output: 1

There is only special position (1, 2) as $matrix[1][2] == 1
and all other elements in row 1 and column 2 are 0.

=head2 Example 2

    Input: $matrix = [ [1, 0, 0],
                       [0, 1, 0],
                       [0, 0, 1],
                     ]
    Output: 3

Special positions are (0,0), (1, 1) and (2,2).

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use List::Util qw/sum0/;

my $cases = [
    [[[1, 0, 0],
      [0, 0, 1],
      [1, 0, 0],
     ], 1],
    [[[1, 0, 0],
      [0, 1, 0],
      [0, 0, 1],
     ], 3],
    [[[1, 0, 0, 1],
      [0, 1, 0, 0],
      [0, 0, 1, 0],
     ], 2],
];

sub special_positions
{
    my $m = shift;

    my $cnt = 0;

    for my $i (0 .. $#$m) {
        next if sum0($m->[$i]->@*) != 1;
        for my $j (0 .. $#{$m->[0]}) {
            if ($m->[$i]->[$j]) {
                my $sum = 0;
                for my $c (0 .. $#$m) {
                    $sum += $m->[$c]->[$j];
                    last if $sum > 1;
                }
                ++$cnt if $sum == 1;
                last;
            }
        }
    }

    return $cnt;
}

for (@$cases) {
    is(special_positions($_->[0]), $_->[1], $_->[2]);
}

done_testing();

exit 0;
