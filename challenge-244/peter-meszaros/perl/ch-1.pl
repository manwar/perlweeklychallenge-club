#!/usr/bin/env perl
#
# You are given an array of integers.
# 
# Write a script to calculate the number of integers smaller than the integer
# at each index.
# Example 1
# 
# Input: @int = (8, 1, 2, 2, 3)
# Output: (4, 0, 1, 1, 3)
# 
# For index = 0, count of elements less 8 is 4.
# For index = 1, count of elements less 1 is 0.
# For index = 2, count of elements less 2 is 1.
# For index = 3, count of elements less 2 is 1.
# For index = 4, count of elements less 3 is 3.
# 
# Example 2
# 
# Input: @int = (6, 5, 4, 8)
# Output: (2, 1, 0, 3)
# 
# Example 3
# 
# Input: @int = (2, 2, 2)
# Output: (0, 0, 0)
# 

use strict;
use warnings;
use Test::More;
use Data::Dumper;

my $cases = [
	[8, 1, 2, 2, 3],
	[6, 5, 4, 8],
	[2, 2, 2],
];

sub count_smaller
{
	my $l = shift;
	
	my @sorted = sort {$a <=> $b} @$l;

	my @res;
	for my $i (0..$#$l) {
		for my $j (0..$#sorted) {
			if ($sorted[$j] >= $l->[$i]) {
				$res[$i] = $j;
				last;
			}
		}
	}
    return \@res;
}

is_deeply(count_smaller($cases->[0]), [4, 0, 1, 1, 3], '[8, 1, 2, 2, 3]');
is_deeply(count_smaller($cases->[1]), [2, 1, 0, 3],    '[6, 5, 4, 8]');
is_deeply(count_smaller($cases->[2]), [0, 0, 0],       '[2, 2, 2]');
done_testing();

exit 0;


