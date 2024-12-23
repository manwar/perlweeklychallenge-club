#!/usr/bin/env perl
#
=head1 Task 1: Largest Number

Submitted by: Mohammad Sajid Anwar

You are given a list of positive integers, @ints.

Write a script to arrange all the elements in the given list such that they
form the largest number and return it.

=head2 Example 1

    Input: @ints = (20, 3)
    Output: 320

=head2 Example 2

    Input: @ints = (3, 30, 34, 5, 9)
    Output: 9534330

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
    [[20, 3],               320, 'Example 1'],
    [[3, 30, 34, 5, 9], 9534330, 'Example 2'],
];

sub largest_number
{
    my $ints = shift;

    return join('', sort { ($b . $a) <=> ($a . $b) } @$ints);
}

for (@$cases) {
    is(largest_number($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
