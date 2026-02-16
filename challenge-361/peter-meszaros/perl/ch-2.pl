#!/usr/bin/env perl
#
=head1 Task 2: Find Celebrity

Submitted by: Mohammad Sajid Anwar

You are given a binary matrix (m x n).  Write a script to find the celebrity,
return -1 when none found.  A celebrity is someone, everyone knows and knows
nobody.

=head2 Example 1

    Input: @party = (
                [0, 0, 0, 0, 1, 0],  # 0 knows 4
                [0, 0, 0, 0, 1, 0],  # 1 knows 4
                [0, 0, 0, 0, 1, 0],  # 2 knows 4
                [0, 0, 0, 0, 1, 0],  # 3 knows 4
                [0, 0, 0, 0, 0, 0],  # 4 knows NOBODY
                [0, 0, 0, 0, 1, 0],  # 5 knows 4
           );
    Output: 4

=head2 Example 2

    Input: @party = (
                [0, 1, 0, 0],  # 0 knows 1
                [0, 0, 1, 0],  # 1 knows 2
                [0, 0, 0, 1],  # 2 knows 3
                [1, 0, 0, 0]   # 3 knows 0
           );
    Output: -1

=head2 Example 3

    Input: @party = (
                [0, 0, 0, 0, 0],  # 0 knows NOBODY
                [1, 0, 0, 0, 0],  # 1 knows 0
                [1, 0, 0, 0, 0],  # 2 knows 0
                [1, 0, 0, 0, 0],  # 3 knows 0
                [1, 0, 0, 0, 0]   # 4 knows 0
           );
    Output: 0

=head2 Example 4

    Input: @party = (
                [0, 1, 0, 1, 0, 1],  # 0 knows 1, 3, 5
                [1, 0, 1, 1, 0, 0],  # 1 knows 0, 2, 3
                [0, 0, 0, 1, 1, 0],  # 2 knows 3, 4
                [0, 0, 0, 0, 0, 0],  # 3 knows NOBODY
                [0, 1, 0, 1, 0, 0],  # 4 knows 1, 3
                [1, 0, 1, 1, 0, 0]   # 5 knows 0, 2, 3
           );
    Output: 3

=head2 Example 5

    Input: @party = (
                [0, 1, 1, 0],  # 0 knows 1 and 2
                [1, 0, 1, 0],  # 1 knows 0 and 2
                [0, 0, 0, 0],  # 2 knows NOBODY
                [0, 0, 0, 0]   # 3 knows NOBODY
           );
    Output: -1

=head2 Example 6

    Input: @party = (
                [0, 0, 1, 1],  # 0 knows 2 and 3
                [1, 0, 0, 0],  # 1 knows 0
                [1, 1, 0, 1],  # 2 knows 0, 1 and 3
                [1, 1, 0, 0]   # 3 knows 0 and 1
          );
    Output: -1

=cut

use strict;
use warnings;
use v5.42.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my $cases = [
    [[[0, 0, 0, 0, 1, 0],
      [0, 0, 0, 0, 1, 0],
      [0, 0, 0, 0, 1, 0],
      [0, 0, 0, 0, 1, 0],
      [0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 1, 0]
        ], 4, "Example 1"],
    [[[0, 1, 0, 0],
      [0, 0, 1, 0],
      [0, 0, 0, 1],
      [1, 0, 0, 0] 
        ], -1, "Example 2"],
    [[[0, 0, 0, 0, 0],
      [1, 0, 0, 0, 0],
      [1, 0, 0, 0, 0],
      [1, 0, 0, 0, 0],
      [1, 0, 0, 0, 0] 
        ], 0, "Example 3"],
    [[[0, 1, 0, 1, 0, 1],
      [1, 0, 1, 1, 0, 0],
      [0, 0, 0, 1, 1, 0],
      [0, 0, 0, 0, 0, 0],
      [0, 1, 0, 1, 0, 0],
      [1, 0, 1, 1, 0, 0] 
        ], 3, "Example 4"],
    [[[0, 1, 1, 0],
      [1, 0, 1, 0],
      [0, 0, 0, 0],
      [0, 0, 0, 0] 
        ], -1, "Example 5"],
    [[[0, 0, 1, 1],
      [1, 0, 0, 0],
      [1, 1, 0, 1],
      [1, 1, 0, 0] 
        ], -1, "Example 6"],
];

sub find_celebrity
{
    my $party = shift;
    my $n = @$party;
    for my $i (0 .. $n - 1) {
        my $knows_nobody = true;
        for my $j (0 .. $n - 1) {
            if ($party->[$i]->[$j]) {
                $knows_nobody = false;
                last;
            }
        }
        next unless $knows_nobody;

        my $known_by_everybody = true;
        for my $k (0 .. $n - 1) {
            if ($k != $i && !$party->[$k]->[$i]) {
                $known_by_everybody = false;
                last;
            }
        }
        return $i if $known_by_everybody;
    }
    return -1;
}

for (@$cases) {
    is(find_celebrity($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
