#!/usr/bin/env perl
#
=head1 Task 1: Magic Number

You are given two arrays of integers of same size, @x and @y.

Write a script to find the magic number that when added to each elements of one
of the array gives the second array. Elements order is not important.

=head2 Example 1

	Input: @x = (3, 7, 5)
		   @y = (9, 5, 7)
	Output: 2

	The magic number is 2.
	@x = (3, 7, 5)
	   +  2  2  2
	@y = (5, 9, 7)

=head2 Example 2

	Input: @x = (1, 2, 1)
		   @y = (5, 4, 4)
	Output: 3

	The magic number is 3.
	@x = (1, 2, 1)
	   +  3  3  3
	@y = (5, 4, 4)

=head2 Example 3

	Input: @x = (2)
		   @y = (5)
	Output: 3

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
	[[[3, 7, 5], [9, 5, 7]], 2],
	[[[1, 2, 1], [5, 4, 4]], 3],
	[[[2],       [5]],       3],
];

sub magic_number
{
	my $l1 = $_[0]->[0];
	my $l2 = $_[0]->[1];

    return undef unless @$l1 == @$l2;

	my @l1 = sort {$a <=> $b} @$l1;
	my @l2 = sort {$a <=> $b} @$l2;

    my $diff = $l2[0] - $l1[0];

    for (my $i=1; $i<@l1; $i++) {
        return undef if $l2[$i] - $l1[$i] != $diff;
    }
	return $diff;
}

for (@$cases) {
    is(magic_number($_->[0]), $_->[1], $_->[2]);
}

done_testing();

exit 0;
