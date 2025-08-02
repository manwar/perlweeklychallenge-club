#!/usr/bin/env perl
#
=head1 Task 1: Check Order

Submitted by: Mohammad Sajid Anwar

You are given an array of integers, @ints.

Write a script to re-arrange the given array in an increasing order and return
the indices where it differs from the original array.

=head2 Example 1

    Input: @ints = (5, 2, 4, 3, 1)
    Output: (0, 2, 3, 4)

    Before: (5, 2, 4, 3, 1)
    After : (1, 2, 3, 4, 5)

    Difference at indices: (0, 2, 3, 4)

=head2 Example 2

    Input: @ints = (1, 2, 1, 1, 3)
    Output: (1, 3)

    Before: (1, 2, 1, 1, 3)
    After : (1, 1, 1, 2, 3)

    Difference at indices: (1, 3)

=head2 Example 3

    Input: @ints = (3, 1, 3, 2, 3)
    Output: (0, 1, 3)

    Before: (3, 1, 3, 2, 3)
    After : (1, 2, 3, 3, 3)

    Difference at indices: (0, 1, 3)

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
    [[5, 2, 4, 3, 1], [0, 2, 3, 4], 'Example 1'],
    [[1, 2, 1, 1, 3], [1, 3],       'Example 2'],
    [[3, 1, 3, 2, 3], [0, 1, 3],    'Example 3'],
];

sub check_order
{
    my $list = shift;
    my @sorted = sort { $a <=> $b } @$list;
    my @diff;
    for my $i (0..$#sorted) {
        push @diff, $i if $list->[$i] != $sorted[$i];
    }
    return \@diff;
}

for (@$cases) {
    is(check_order($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
