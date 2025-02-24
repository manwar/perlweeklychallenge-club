#!/usr/bin/env perl
#
=head1 Task 2: Sort Odd Even

Submitted by: Mohammad Sajid Anwar

You are given an array of integers.

Write a script to sort odd index elements in decreasing order and even index
elements in increasing order in the given array.

=head2 Example 1

    Input: @ints = (4, 1, 2, 3)
    Output: (2, 3, 4, 1)

    Even index elements: 4, 2 => 2, 4 (increasing order)
    Odd index elements : 1, 3 => 3, 1 (decreasing order)

=head2 Example 2

    Input: @ints = (3, 1)
    Output: (3, 1)

=head2 Example 3

    Input: @ints = (5, 3, 2, 1, 4)
    Output: (2, 3, 4, 1, 5)

    Even index elements: 5, 2, 4 => 2, 4, 5 (increasing order)
    Odd index elements : 3, 1 => 3, 1 (decreasing order)

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
    [[4, 1, 2, 3],    [2, 3, 4, 1],    'Example 1'],
    [[3, 1],          [3, 1],          'Example 2'],
    [[5, 3, 2, 1, 4], [2, 3, 4, 1, 5], 'Example 3'],
];

sub sort_odd_even
{
    my $list = shift;

    my @even = sort {$a <=> $b} $list->@[grep {$_ % 2 == 0} 0 .. $#$list];
    my @odd  = sort {$b <=> $a} $list->@[grep {$_ % 2 != 0} 0 .. $#$list];

    my @sorted;
    for my $i (0 .. $#even) {
        push @sorted, $even[$i];
        push @sorted, $odd[$i] if defined $odd[$i];
    }

    return \@sorted;
}

for (@$cases) {
    is(sort_odd_even($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
