#!/usr/bin/env perl
#
=head1 Task 2: Zero Array

You are given an array of non-negative integers, @ints.

Write a script to return the minimum number of operations to make every element
equal zero.

	In each operation, you are required to pick a positive number less than or
	equal to the smallest element in the array, then subtract that from each
	positive element in the array.

=head2 Example 1:

    Input: @ints = (1, 5, 0, 3, 5)
    Output: 3

    operation 1: pick 1 => (0, 4, 0, 2, 4)
    operation 2: pick 2 => (0, 2, 0, 0, 2)
    operation 3: pick 2 => (0, 0, 0, 0, 0)

=head2 Example 2:

    Input: @ints = (0)
    Output: 0

=head2 Example 3:

    Input: @ints = (2, 1, 4, 0, 3)
    Output: 4

    operation 1: pick 1 => (1, 0, 3, 0, 2)
    operation 2: pick 1 => (0, 0, 2, 0, 1)
    operation 3: pick 1 => (0, 0, 1, 0, 0)
    operation 4: pick 1 => (0, 0, 0, 0, 0)

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use List::Util qw/uniqint/;

my $cases = [
	[[1, 5, 0, 3, 5], 3],
	[[0],             0],
	[[2, 1, 4, 0, 3], 4],
];

sub zero_array
{
    my $arr = $_[0];
    return scalar uniqint grep $_, @$arr;
}

for (@$cases) {
    is(zero_array($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;

