#!/usr/bin/env perl
#
=head1 Task 1: Chessboard Squares

Submitted by: Mohammad Sajid Anwar

You are given two coordinates of a square on 8x8 chessboard.
Write a script to find the given two coordinates have the same colour.

    8 W B W B W B W B
    7 B W B W B W B W
    6 W B W B W B W B
    5 B W B W B W B W
    4 W B W B W B W B
    3 B W B W B W B W
    2 W B W B W B W B
    1 B W B W B W B W
      a b c d e f g h

=head2 Example 1

    Input: $c1 = "a7", $c2 = "f4"
    Output: true

=head2 Example 2

    Input: $c1 = "c1", $c2 = "e8"
    Output: false

=head2 Example 3

    Input: $c1 = "b5", $c2 = "h2"
    Output: false

=head2 Example 4

    Input: $c1 = "f3", $c2 = "h1"
    Output: true

=head2 Example 5

    Input: $c1 = "a1", $c2 = "g8"
    Output: false

=cut

use strict;
use warnings;
use v5.42.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my $cases = [
    [["a7", "f4"], true,  "Example 1"],
    [["c1", "e8"], false, "Example 2"],
    [["b5", "h2"], false, "Example 3"],
    [["f3", "h1"], true,  "Example 4"],
    [["a1", "g8"], false, "Example 5"],
];

sub chessboard_squares
{
    my $c1 = $_[0]->[0];
    my $c2 = $_[0]->[1];

    my $x1 = ord(substr($c1, 0, 1)) - ord('a') + 1;
    my $y1 = substr($c1, 1, 1);
    my $x2 = ord(substr($c2, 0, 1)) - ord('a') + 1;
    my $y2 = substr($c2, 1, 1);

    return (($x1 + $y1) % 2 == ($x2 + $y2) % 2) ? true : false;
}

for (@$cases) {
    is(chessboard_squares($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
