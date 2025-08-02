#!/usr/bin/env perl
#
=head1 Task 1: 2D Array

Submitted by: Mohammad Sajid Anwar

You are given an array of integers and two integers $r amd $c.

Write a script to create two dimension array having $r rows and $c columns
using the given array.

=head2 Example 1

    Input: @ints = (1, 2, 3, 4), $r = 2, $c = 2
    Output: ([1, 2], [3, 4])

=head2 Example 2

    Input: @ints = (1, 2, 3), $r = 1, $c = 3
    Output: ([1, 2, 3])

=head2 Example 3

    Input: @ints = (1, 2, 3, 4), $r = 4, $c = 1
    Output: ([1], [2], [3], [4])

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
    [[[1, 2, 3, 4], 2, 2], [[1, 2], [3, 4]],     "Example 1"],
    [[[1, 2, 3],    1, 3], [[1, 2, 3]],          "Example 2"],
    [[[1, 2, 3, 4], 4, 1], [[1], [2], [3], [4]], "Example 3"],
];

sub two_d_array
{
    my $ints = $_[0]->[0];
    my $r    = $_[0]->[1];
    my $c    = $_[0]->[2];

    return undef unless @$ints == ($r * $c);

    my @result;
    for my $i (0 .. $r - 1) {
        my @row = $ints->@[($i * $c) .. ($i * $c + $c - 1)];
        push @result, \@row;
    }
    return \@result;
}

for (@$cases) {
    is(two_d_array($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
