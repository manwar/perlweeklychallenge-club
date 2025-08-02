#!/usr/bin/env perl
#
# You are given a array of integers, @ints.
# 
# Write a script to find out how many integers are smaller than current i.e.
# foreach ints[i], count ints[j] < ints[i] where i != j.
# Example 1
# 
# Input: @ints = (5, 2, 1, 6)
# Output: (2, 1, 0, 3)
# 
# For $ints[0] = 5, there are two integers (2,1) smaller than 5.
# For $ints[1] = 2, there is one integer (1) smaller than 2.
# For $ints[2] = 1, there is none integer smaller than 1.
# For $ints[3] = 6, there are three integers (5,2,1) smaller than 6.
# 
# Example 2
# 
# Input: @ints = (1, 2, 0, 3)
# Output: (1, 2, 0, 3)
# 
# Example 3
# 
# Input: @ints = (0, 1)
# Output: (0, 1)
# 
# Example 4
# 
# Input: @ints = (9, 4, 9, 2)
# Output: (2, 1, 2, 0)
# 

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
	[5, 2, 1, 6],
	[1, 2, 0, 3],
	[0, 1],
	[9, 4, 9, 2],
];

sub smaller_than_current
{
	my $l = shift;

	my @res;
	for my $i (0..$#$l) {
		my $c = 0;
		for my $j (0..$#$l) {
			if ($j == $i) {
				next;
			} elsif ($l->[$j] < $l->[$i]) {
				++$c;
			}
		}
		$res[$i] = $c;
	}

	return \@res;;
}

is(smaller_than_current($cases->[0]), [2, 1, 0, 3], 'Example 1');
is(smaller_than_current($cases->[1]), [1, 2, 0, 3], 'Example 2');
is(smaller_than_current($cases->[2]), [0, 1],       'Example 3');
is(smaller_than_current($cases->[3]), [2, 1, 2, 0], 'Example 4');
done_testing();

exit 0;
