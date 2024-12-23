#!/usr/bin/env perl
#
=head1 Task 2: Hamming Distance

Submitted by: Mohammad Sajid Anwar

You are given an array of integers, @ints.

Write a script to return the sum of Hamming distances between all the pairs of
the integers in the given array of integers.

The Hamming distance between two integers is the number of places in which
their binary representations differ.

=head2 Example 1

    Input: @ints = (4, 14, 2)
    Output: 6

    Binary representation:
    4  => 0100
    14 => 1110
    2  => 0010

    HammingDistance(4, 14) + HammingDistance(4, 2) + HammingDistance(14, 2) = 2
    + 2 + 2 = 6.

=head2 Example 2

    Input: @ints = (4, 14, 4)
    Output: 4

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use Algorithm::Combinatorics qw/combinations/;

my $cases = [
    [[4, 14, 2], 6, 'Example 1'],
    [[4, 14, 4], 4, 'Example 2'],
];

sub calculate_hamming_distance
{
    my ($n1, $n2) = @_;

	my $x = $n1 ^ $n2;
	my $dist = 0;

	while ($x > 0) {
		$dist += $x & 1;
		$x >>= 1;
    }

	return $dist;
}

sub hamming_distance
{
    my $ints = shift;

    my $iter = combinations($ints, 2);
    my $sum = 0;
    while (my $c = $iter->next) {
        $sum += calculate_hamming_distance(@$c);
    }

    return $sum;
}

for (@$cases) {
    is(hamming_distance($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
