#!/usr/bin/env perl
#
=head1 Task 1: Pattern 132

Submitted by: Mohammad S Anwar

You are given a list of integers, @list.

Write a script to find out subsequence that respect Pattern 132. Return empty
array if none found.

    Pattern 132 in a sequence (a[i], a[j], a[k]) such that i < j < k and a[i] <
    a[k] < a[j].

=head2 Example 1

    Input:  @list = (3, 1, 4, 2)
    Output: (1, 4, 2) respect the Pattern 132.

=head2 Example 2

    Input: @list = (1, 2, 3, 4)
    Output: () since no susbsequence can be found.

=head2 Example 3

    Input: @list = (1, 3, 2, 4, 6, 5)
    Output: (1, 3, 2) if more than one subsequence found then return the first.

=head2 Example 4

    Input: @list = (1, 3, 4, 2)
    Output: (1, 3, 2)

=cut

use strict;
use warnings;
use v5.42.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my $cases = [
    [[3, 1, 4, 2],       [1, 4, 2], 'Example 1'],
    [[1, 2, 3, 4],       [],        'Example 2'],
    [[1, 3, 2, 4, 6, 5], [1, 3, 2], 'Example 3'],
    [[1, 3, 4, 2],       [1, 3, 2], 'Example 4'],
];

sub pattern_132
{
    my $l = shift;

    for my $i (0 .. $#$l-2) {
        for my $j (1 .. $#$l-1) {
            for my $k (2 .. $#$l) {
                my @l = $l->@[$i, $j, $k];
                if ($l[0] < $l[2] && $l[2] < $l[1]) {
                    return \@l;
                }
            }
        }
    }
    return [];
}

for (@$cases) {
    is(pattern_132($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
