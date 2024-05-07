#!/usr/bin/env perl
#
=head1 Task 2: Number Game

You are given an array of integers, @ints, with even number of elements.

Write a script to create a new array made up of elements of the given array.
Pick the two smallest integers and add it to new array in decreasing order i.e.
high to low. Keep doing until the given array is empty.

=head2 Example 1

	Input: @ints = (2, 5, 3, 4)
	Output: (3, 2, 5, 4)

	Round 1: we picked (2, 3) and push it to the new array (3, 2)
	Round 2: we picked the remaining (4, 5) and push it to the new array (5, 4)

=head2 Example 2

	Input: @ints = (9, 4, 1, 3, 6, 4, 6, 1)
	Output: (1, 1, 4, 3, 6, 4, 9, 6)

=head2 Example 3

	Input: @ints = (1, 2, 2, 3)
	Output: (2, 1, 3, 2)

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
	[[2, 5, 3, 4],             [3, 2, 5, 4]],
	[[9, 4, 1, 3, 6, 4, 6, 1], [1, 1, 4, 3, 6, 4, 9, 6]],
	[[1, 2, 2, 3],             [2, 1, 3, 2]],
];

sub number_game
{
	my $l = shift;

    return undef if @$l % 2;

	my @l = sort {$a <=> $b} @$l;
	my @res;

	for (my $i=0; $i<@l; $i+=2 ) {
		push @res, @l[$i+1, $i];
	}

	return \@res;
}

for (@$cases) {
    is(number_game($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;

