#!/usr/bin/env perl
#
=head1 Task 1: Good Pairs

Submitted by: Mohammad S Anwar

You are given a list of integers, @list.

Write a script to find the total count of Good Pairs.

    A pair (i, j) is called good if list[i] == list[j] and i < j.

=head2 Example 1

    Input: @list = (1,2,3,1,1,3)
    Output: 4

    There are 4 good pairs found as below:
    (0,3)
    (0,4)
    (3,4)
    (2,5)

=head2 Example 2

    Input: @list = (1,2,3)
    Output: 0

=head2 Example 3

    Input: @list = (1,1,1,1)
    Output: 6

    Good pairs are below:
    (0,1)
    (0,2)
    (0,3)
    (1,2)
    (1,3)
    (2,3)

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
    [[1, 2, 3, 1, 1, 3], 4, 'Example 1'],
    [[1, 2, 3],          0, 'Example 2'],
    [[1, 1, 1, 1],       6, 'Example 3'],
];

sub good_pairs
{
    my $l = shift;

    my $cnt = 0;
    for my $i (0 .. $#$l) {
        for my $j ($i+1 .. $#$l) {
            ++$cnt if $l->[$i] == $l->[$j];
        }
    }

    return $cnt;
}

for (@$cases) {
    is(good_pairs($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
