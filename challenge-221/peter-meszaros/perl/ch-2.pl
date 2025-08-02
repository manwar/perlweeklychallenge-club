#!/usr/bin/env perl
#
=head1 Task 2: Arithmetic Subsequence

You are given an array of integers, @ints.

Write a script to find the length of the longest Arithmetic Subsequence in the
given array.

    A subsequence is an array that can be derived from another array by
    deleting some or none elements without changing the order of the remaining
    elements.

    A subsquence is arithmetic if ints[i + 1] - ints[i] are all the same value
    (for 0 <= i < ints.length - 1).

=head2 Example 1:

    Input: @ints = (9, 4, 7, 2, 10)
    Output: 3

The longest Arithmetic Subsequence (4, 7, 10) can be derived by deleting 9 and 2.

=head2 Example 2:

    Input: @ints = (3, 6, 9, 12)
    Output: 4

No need to remove any elements, it is already an Arithmetic Subsequence.

=head2 Example 3:

    Input: @ints = (20, 1, 15, 3, 10, 5, 8)
    Output: 4

The longest Arithmetic Subsequence (20, 15, 10, 5) can be derived by deleting 1, 3 and 8.

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use List::Util qw/max/;

my $cases = [
    [[9, 4, 7, 2, 10],         3],
    [[3, 6, 9, 12],            4],
    [[20, 1, 15, 3, 10, 5, 8], 4],
];

sub arithmetic_subsequence
{
	my $arr = shift;
	my $n = $#$arr;

	my $ans = 0;
	for my $i (0 .. $n-1) {
		for my $j ($i+1 .. $n) {
			my $diff = $arr->[$j] - $arr->[$i];
			my $len = 2;
			my $curr = $arr->[$j];
			for my $k (($j+1) .. $n) {
				if ($arr->[$k] - $curr == $diff) {
					++$len;
					$curr = $arr->[$k];
				}
			}
			$ans = max $ans, $len;
		}
	}
	return $ans;
}

for (@$cases) {
    is(arithmetic_subsequence($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;

