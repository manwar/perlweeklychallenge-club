#!/usr/bin/env perl
#
=head1 Task 1: Missing Integers

Submitted by: Mohammad Sajid Anwar

You are given an array of n integers.

Write a script to find all the missing integers in the range 1..n in the given
array.

=head2 Example 1

    Input: @ints = (1, 2, 1, 3, 2, 5)
    Output: (4, 6)

    The given array has 6 elements.
    So we are looking for integers in the range 1..6 in the given array.
    The missing integers: (4, 6)

=head2 Example 2

    Input: @ints = (1, 1, 1)
    Output: (2, 3)

=head2 Example 3

    Input: @ints = (2, 2, 1)
    Output: (3)

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
    [[1, 2, 1, 3, 2, 5], [4, 6], "Example 1"],
    [[1, 1, 1],          [2, 3], "Example 2"],
    [[2, 2, 1],          [3],    "Example 3"],
];

sub missing_integers
{
    my $ints = shift;

    my $n = @$ints;
    my %seen = map { $_ => 1 } @$ints;
    my @missing;
    for my $i (1 .. $n) {
        push @missing, $i unless exists $seen{$i};
    }
    return \@missing;
}

for (@$cases) {
    is(missing_integers($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
