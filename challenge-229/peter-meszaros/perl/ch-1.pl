#!/usr/bin/env perl
#
=head1 Task 1: Lexicographic Order

You are given an array of strings.
Write a script to delete element which is not lexicographically sorted
(forwards or backwards) and return the count of deletions.

=head2 Example 1

Input: @str = ("abc", "bce", "cae")

Output: 1

In the given array "cae" is the only element which is not lexicographically
sorted.

=head2 Example 2

Input: @str = ("yxz", "cba", "mon")

Output: 2

In the given array "yxz" and "mon" are not lexicographically sorted.

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
	[["abc", "bce", "cae"], 1],
	[["yxz", "cba", "mon"], 2],
];

sub lexicographic_order
{
	my $l = shift;

	my $n = 0;
	my @w;

	for my $w (@$l) {
		my $s = join '', sort split(//, $w);
		my $sr = join '', sort {$b cmp $a} split(//, $w);
		if ($w eq $s || $w eq $sr) {
			push @w, $w;
		} else {
			++$n;
		}
	}
	print join(',', @w), "\n";

	return $n;
}

for (@$cases) {
    is(lexicographic_order($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
