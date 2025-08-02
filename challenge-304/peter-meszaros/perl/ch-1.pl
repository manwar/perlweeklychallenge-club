#!/usr/bin/env perl
#
=head1 Task 1: Arrange Binary

Submitted by: Mohammad Sajid Anwar

You are given a list of binary digits (0 and 1) and a positive integer, $n.

Write a script to return true if you can re-arrange the list by replacing at
least $n digits with 1 in the given list so that no two consecutive digits are
1 otherwise return false.

=head2 Example 1

    Input: @digits = (1, 0, 0, 0, 1), $n = 1
    Output: true

    Re-arranged list: (1, 0, 1, 0, 1)

=head2 Example 2

    Input: @digits = (1, 0, 0, 0, 1), $n = 2
    Output: false

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
    [[[1, 0, 0, 0, 1], 1], 1, 'Example 1'],
    [[[1, 0, 0, 0, 1], 2], 0, 'Example 2'],
];

sub arrange_binary
{
    my $l = $_[0]->[0];
    my $n = $_[0]->[1];

    my $count = 0;
    for my $i (0 .. $#$l-1) {
        ++$count if $l->[$i] == 0 && $l->[$i+1] == 0;
    }

    return $count > $n ? 1 : 0;
}

for (@$cases) {
    is(arrange_binary($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
