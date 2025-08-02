#!/usr/bin/env perl
#
=head1 Task 2: Relative Sort

Submitted by: Mohammad Sajid Anwar

You are given two list of integers, @list1 and @list2. The elements in the
@list2 are distinct and also in the @list1.

Write a script to sort the elements in the @list1 such that the relative order
of items in @list1 is same as in the @list2. Elements that is missing in @list2
should be placed at the end of @list1 in ascending order.

=head2 Example 1

	Input: @list1 = (2, 3, 9, 3, 1, 4, 6, 7, 2, 8, 5)
		   @list2 = (2, 1, 4, 3, 5, 6)
	Ouput: (2, 2, 1, 4, 3, 3, 5, 6, 7, 8, 9)

=head2 Example 2

	Input: @list1 = (3, 3, 4, 6, 2, 4, 2, 1, 3)
		   @list2 = (1, 3, 2)
	Ouput: (1, 3, 3, 3, 2, 2, 4, 4, 6)

=head2 Example 3

	Input: @list1 = (3, 0, 5, 0, 2, 1, 4, 1, 1)
		   @list2 = (1, 0, 3, 2)
	Ouput: (1, 1, 1, 0, 0, 3, 2, 4, 5)

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
	[[[2, 3, 9, 3, 1, 4, 6, 7, 2, 8, 5], [2, 1, 4, 3, 5, 6]],
     [2, 2, 1, 4, 3, 3, 5, 6, 7, 8, 9], 'Example 1'],
    [[[3, 3, 4, 6, 2, 4, 2, 1, 3], [1, 3, 2]],
     [1, 3, 3, 3, 2, 2, 4, 4, 6],       'Example 2'],
    [[[3, 0, 5, 0, 2, 1, 4, 1, 1], [1, 0, 3, 2]],
     [1, 1, 1, 0, 0, 3, 2, 4, 5],       'Example 3'],
];

sub relative_sort
{
	my $l1 = $_[0]->[0];
	my $l2 = $_[0]->[1];

	my %h;
	$h{$l2->[$_]} = $_ for 0 .. $#$l2;

	my (@res, @rem);
	for my $i (@$l1) {
		if (exists $h{$i}) {
			push @res, $i;
		} else {
			push @rem, $i;
		}
	}
	@res = sort { $h{$a} <=> $h{$b} } @res;
	push @res, sort {$a <=> $b} @rem;
	return \@res;
}

for (@$cases) {
    is(relative_sort($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
