#!/usr/bin/env perl
#
=head1 Task 1: Ones and Zeroes

Submitted by: Mohammad Sajid Anwar

You are given an array of binary strings, @str, and two integers, $x and $y.

Write a script to return the size of the largest subset of @str such that there
are at most $x 0's and $y 1's in the subset.

A set m is a subset of n if all elements of m are also elements of n.

=head2 Example 1

    Input: @str = ("10", "0001", "111001", "1", "0")
           $x = 5
           $y = 3
    Output: 4

    The largest subset with at most five 0's and three 1's: ("10", "0001", "1",
    "0")

=head2 Example 2

    Input: @str = ("10", "1", "0")
           $x = 1
           $y = 1
    Output: 2

    The largest subset with at most one 0's and one 1's: ("1", "0")

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
    [[["10", "0001", "111001", "1", "0"], 5, 3], 4, 'Example 1'],
    [[["10",    "1",      "0"],           1, 1], 3, 'Example 2'],
];

sub ones_and_zeroes
{
    my $l = $_[0]->[0];
    my $x = $_[0]->[1];
    my $y = $_[0]->[2];

    my $cnt = 0;
    for my $i (@$l) {
        my @l = split //, $i;
        my $z = grep { $_ eq '0' } @l;
        ++$cnt if $z <= $x && (@l - $z) <= $y;
    }
    return $cnt;
}

for (@$cases) {
    is(ones_and_zeroes($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
