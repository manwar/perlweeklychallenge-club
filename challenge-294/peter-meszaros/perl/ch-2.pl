#!/usr/bin/env perl
#
=head1 Task 2: Next Permutation

Submitted by: Mohammad Sajid Anwar

You are given an array of integers, @ints.

Write a script to find out the next permutation of the given array.

    The next permutation of an array of integers is the next lexicographically
    greater permutation of its integer.

=head2 Example 1

    Input: @ints = (1, 2, 3)
    Output: (1, 3, 2)

    Permutations of (1, 2, 3) arranged lexicographically:
    (1, 2, 3)
    (1, 3, 2)
    (2, 1, 3)
    (2, 3, 1)
    (3, 1, 2)
    (3, 2, 1)

=head2 Example 2

    Input: @ints = (2, 1, 3)
    Output: (2, 3, 1)

=head2 Example 3

    Input: @ints = (3, 1, 2)
    Output: (3, 2, 1)

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use Algorithm::Combinatorics qw/permutations/;

my $cases = [
    [[1, 2, 3], [1, 3, 2], 'Example 1'],
    [[2, 1, 3], [2, 3, 1], 'Example 2'],
    [[3, 1, 2], [3, 2, 1], 'Example 3'],
    [[2, 3, 1], [3, 2, 1], 'Example 4'],
];

sub next_permutation
{
    my $l = shift;

    my $iter = permutations($l);
    NEXTITER: while (my $p = $iter->next) {
        for my $i (0 .. $#$l) {
            if ($l->[$i] < $p->[$i]) {
                return $p;
            } elsif ($l->[$i] > $p->[$i]) {
                next NEXTITER;
            }
        }
    }

    return undef;
}

for (@$cases) {
    is(next_permutation($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
