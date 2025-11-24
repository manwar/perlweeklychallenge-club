#!/usr/bin/env perl
#
=head1 Task 2: Meeting Point

Submitted by: Mohammad Sajid Anwar

You are given instruction string made up of U (up), D (down), L (left) and R
(right).

Write a script to return true if following the instruction, you meet (0,0) at
any point along the sequence.

=head2 Example 1

    Input: $path = "ULD"
    Output: false

    (-1,1) <- (0,1)
       |        ^
       v        |
    (-1,0)    (0,0)

=head2 Example 2

    Input: $path = "ULDR"
    Output: true

    (-1,1) <- (0,1)
       |        ^
       v        |
    (-1,0) -> (0,0)

=head2 Example 3

    Input: $path = "UUURRRDDD"
    Output: false

    (0,3) -> (1,3) -> (2,3) -> (3,3)
      ^                          |
      |                          v
    (0,2)                      (3,2)
      ^                          |
      |                          v
    (0,1)                      (3,1)
      ^                          |
      |                          v
    (0,0)                      (3,0)

=head2 Example 4

    Input: $path = "UURRRDDLLL"
    Output: true

    (0,2) -> (1,2) -> (2,2) -> (3,2)
      ^                          |
      |                          v
    (0,1)                      (3,1)
      ^                          |
      |                          v
    (0,0) <- (1,0) <- (1,1) <- (3,0)

=head2 Example 5

    Input: $path = "RRUULLDDRRUU"
    Output: true

    (0,2) <- (1,2) <- (2,2)
      |                 ^
      v                 |
    (0,1)             (2,1)
      |                 ^
      v                 |
    (0,0) -> (1,0) -> (2,1)

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my $cases = [
    ["ULD",          false, "Example 1"],
    ["ULDR",         true,  "Example 2"],
    ["UUURRRDDD",    false, "Example 3"],
    ["UURRRDDLLL",   true,  "Example 4"],
    ["RRUULLDDRRUU", true,  "Example 5"],
];

sub meeting_point
{
    my $path = shift;

    my ($x, $y) = (0, 0);
    for my $move (split //, $path) {
        if    ($move eq 'U') { $y++ }
        elsif ($move eq 'D') { $y-- }
        elsif ($move eq 'L') { $x-- }
        elsif ($move eq 'R') { $x++ }

        return true if $x == 0 && $y == 0;
    }
    return false;
}

for (@$cases) {
    is(meeting_point($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
