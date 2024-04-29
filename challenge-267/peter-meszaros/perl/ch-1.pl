#!/usr/bin/env perl
#
=head1 Task 1: Product Sign

You are given an array of @ints.

Write a script to find the sign of product of all integers in the given array.
The sign is 1 if the product is positive, -1 if the product is negative and 0
if product is zero.

=head2 Example 1

Input: @ints = (-1, -2, -3, -4, 3, 2, 1)

Output: 1

The product -1 x -2 x -3 x -4 x 3 x 2 x 1 => 144 > 0

=head2 Example 2

Input: @ints = (1, 2, 0, -2, -1)

Output: 0

The product 1 x 2 x 0 x -2 x -1 => 0

=head2 Example 3

Input: @ints = (-1, -1, 1, -1, 2)

Output: -1

The product -1 x -1 x 1 x -1 x 2 => -2 < 0

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
	[[-1, -2, -3, -4, 3, 2, 1], 1],
	[[1, 2, 0, -2, -1],         0],
	[[-1, -1, 1, -1, 2],       -1],
];

sub product_sign
{
	my $l = shift;

	my $res = 1;

	$res *= $_ for @$l;

	return $res <=> 0;
}

for (@$cases) {
    is(product_sign($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
