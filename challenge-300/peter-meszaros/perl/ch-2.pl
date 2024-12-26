#!/usr/bin/env perl
#
=head1 Task 2: Nested Array

Submitted by: Mohammad Sajid Anwar

You are given an array of integers, @ints of length n containing permutation of
the numbers in the range [0, n - 1].

Write a script to build a set, set[i] = ints[i], ints[ints[i]],
ints[ints[ints[i]]], ..., subjected to the following rules:

    1. The first element in set[i] starts with the selection of elements
        ints[i].
    2. The next element in set[i] should be ints[ints[i]], and then
        ints[ints[ints[i]]], and so on.
    3. We stop adding right before a duplicate element occurs in set[i].

Return the longest length of a set set[i].

=head2 Example 1

    Input: @ints = (5, 4, 0, 3, 1, 6, 2)
    Output: 4

    ints[0] = 5
    ints[1] = 4
    ints[2] = 0
    ints[3] = 3
    ints[4] = 1
    ints[5] = 6
    ints[6] = 2

    One of the longest sets set[k]:
    set[0] = {ints[0], ints[5], ints[6], ints[2]} = {5, 6, 2, 0}

=head2 Example 2

    Input: @ints = (0, 1, 2)
    Output: 1

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
    [[5, 4, 0, 3, 1, 6, 2], 4, 'Example 1'],
    [[0, 1, 2],             1, 'Example 2'],
];

sub nested_array
{
    my $l = shift;

    my $res = 0;
    for my $i (0 .. $#$l) {
        my $cnt = 1;
        my @l = @$l;
        my $n = $l[$i];
        $l[$i] = -1;
        while ($l[$n] != -1) {
            $cnt++;
            my $t = $n;
            $n = $l[$n];
            $l[$t] = -1;
        }
        $res = $cnt if $cnt > $res;
    }
    return $res;
}

for (@$cases) {
    is(nested_array($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
