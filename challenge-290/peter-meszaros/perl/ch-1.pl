#!/usr/bin/env perl
#
=head1 Task 1: Double Exist

Submitted by: Mohammad Sajid Anwar

You are given an array of integers, @ints.

Write a script to find if there exist two indices $i and $j such that:

    1) $i != $j
    2) 0 <= ($i, $j) < scalar @ints
    3) $ints[$i] == 2 * $ints[$j]

=head2 Example 1

    Input: @ints = (6, 2, 3, 3)
    Output: true

    For $i = 0, $j = 2
    $ints[$i] = 6 => 2 * 3 =>  2 * $ints[$j]

=head2 Example 2

    Input: @ints = (3, 1, 4, 13)
    Output: false

=head2 Example 3

    Input: @ints = (2, 1, 4, 2)
    Output: true

    For $i = 2, $j = 3
    $ints[$i] = 4 => 2 * 2 =>  2 * $ints[$j]

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
    [[6, 2, 3,  3], 1, 'Example 1'],
    [[3, 1, 4, 13], 0, 'Example 2'],
    [[2, 1, 4,  2], 1, 'Example 3'],
];

sub double_exists
{
    my $l = shift;

    my %h;
    $h{$l->[$_] * 2} = $_ for 0 .. $#$l;

    for my $i (0 .. $#$l) {
        return 1 if defined $h{$l->[$i]} and $h{$l->[$i]} != $i;
    }

    return 0;
}

for (@$cases) {
    is(double_exists($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
