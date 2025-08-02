#!/usr/bin/env perl
#
=head1 Task 1: Check Color
Submitted by: Mohammad Sajid Anwar
You are given coordinates, a string that represents the coordinates of a square
of the chessboard as shown below:
      +-+-+-+-+-+-+-+-+
    8 | |#| |#| |#| |#|
    7 |#| |#| |#| |#| |
    6 | |#| |#| |#| |#|
    5 |#| |#| |#| |#| |
    4 | |#| |#| |#| |#|
    3 |#| |#| |#| |#| |
    2 | |#| |#| |#| |#|
    1 |#| |#| |#| |#| |
      +-+-+-+-+-+-+-+-+
       a b c d e f g h
Write a script to return true if the square is light, and false if the square
is dark.
=head2 Example 1
    Input: $coordinates = "d3"
    Output: true
=head2 Example 2
    Input: $coordinates = "g5"
    Output: false
=head2 Example 3
    Input: $coordinates = "e6"
    Output: true
=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
    ['d3', 1, 'Example 1'],
    ['g5', 0, 'Example 2'],
    ['e6', 1, 'Example 3'],
];

sub check_color
{
    my $pos = shift;

    my ($x, $y) = split '', $pos;

    return (ord($x) + $y) % 2;
}

for (@$cases) {
    is(check_color($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
