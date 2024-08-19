#!/usr/bin/env perl
#
=head1 Task 1: Maximum Product

Submitted by: Mohammad S Anwar

You are given a list of 3 or more integers.

Write a script to find the 3 integers whose product is the maximum and return
it.

=head2 Example 1

	Input: @list = (3, 1, 2)
	Output: 6

	1 x 2 x 3 => 6

=head2 Example 2

	Input: @list = (4, 1, 3, 2)
	Output: 24

	2 x 3 x 4 => 24

=head2 Example 3

	Input: @list = (-1, 0, 1, 3, 1)
	Output: 3

	1 x 1 x 3 => 3

=head2 Example 4

	Input: @list = (-8, 2, -9, 0, -4, 3)
	Output: 216

	-9 x -8 x 3 => 216

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use List::Util qw/max/;

my $cases = [
    [[ 3, 1,  2],             6, 'Example 1'],
    [[ 4, 1,  3, 2],         24, 'Example 2'],
    [[-1, 0,  1, 3,  1],      3, 'Example 3'],
    [[-8, 2, -9, 0, -4, 3], 216, 'Example 4'],
];

sub maximum_product
{
    my $l = shift;

    my @sl = sort { $a <=> $b } @$l;
    return max($sl[-1] * $sl[-2] * $sl[-3], $sl[0] * $sl[1] * $sl[-1]);
}

for (@$cases) {
    is(maximum_product($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
