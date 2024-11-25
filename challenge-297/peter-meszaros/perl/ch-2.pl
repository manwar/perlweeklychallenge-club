#!/usr/bin/env perl
#
=head1 Task 2: Semi-Ordered Permutation

Submitted by: Mohammad Sajid Anwar

You are given permutation of $n integers, @ints.

Write a script to find the minimum number of swaps needed to make the @ints a
semi-ordered permutation.

    A permutation is a sequence of integers from 1 to n of length n containing
    each number exactly once.

    A permutation is called semi-ordered if the first number is 1 and the last
    number equals n.

You are ONLY allowed to pick adjacent elements and swap them.

=head2 Example 1

    Input: @ints = (2, 1, 4, 3)
    Output: 2

    Swap 2 <=> 1 => (1, 2, 4, 3)
    Swap 4 <=> 3 => (1, 2, 3, 4)

=head2 Example 2

    Input: @ints = (2, 4, 1, 3)
    Output: 3

    Swap 4 <=> 1 => (2, 1, 4, 3)
    Swap 2 <=> 1 => (1, 2, 4, 3)
    Swap 4 <=> 3 => (1, 2, 3, 4)

=head2 Example 3

    Input: @ints = (1, 3, 2, 4, 5)
    Output: 0

    Already a semi-ordered permutation.

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
    [[2, 1, 4, 3],    2, 'Example 1'],
    [[2, 4, 1, 3],    3, 'Example 2'],
    [[1, 3, 2, 4, 5], 0, 'Example 3'],
    [[2, 5, 4, 1, 3], 5, 'Example 4'],
];

sub semi_ordered_permutation
{
    my $l = shift;
   
    my $minidx = 0;
    my $maxidx = 0;
    for my $i (1 .. $#$l) {
        $minidx = $i if $l->[$i] < $l->[$minidx];
        $maxidx = $i if $l->[$i] > $l->[$maxidx];
    }
    return $minidx + $#$l - $maxidx - ($minidx > $maxidx ? 1 : 0);
}

for (@$cases) {
    is(semi_ordered_permutation($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
