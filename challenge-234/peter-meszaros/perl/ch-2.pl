#!/usr/bin/env perl

# You are given an array of positive integers.
# 
# Write a script to find the number of triplets (i, j, k) that satisfies
# num[i] != num[j], num[j] != num[k] and num[k] != num[i].
# Example 1
# 
# Input: @ints = (4, 4, 2, 4, 3)
# Ouput: 3
# 
# (0, 2, 4) because 4 != 2 != 3
# (1, 2, 4) because 4 != 2 != 3
# (2, 3, 4) because 2 != 4 != 3
# 
# Example 2
# 
# Input: @ints = (1, 1, 1, 1, 1)
# Ouput: 0
# 
# Example 3
# 
# Input: @ints = (4, 7, 1, 10, 7, 4, 1, 1)
# Output: 28
# 
# triplets of 1, 4, 7  = 3x2×2 = 12 combinations
# triplets of 1, 4, 10 = 3×2×1 = 6  combinations
# triplets of 4, 7, 10 = 2×2×1 = 4  combinations
# triplets of 1, 7, 10 = 3x2x1 = 6 combinations
# 

use strict;
use warnings;
use Test::More;
use Data::Dumper;
use Algorithm::Combinatorics qw/combinations/;

my $cases = [
	[4, 4, 2, 4, 3],
	[1, 1, 1, 1, 1],
	[4, 7, 1, 10, 7, 4, 1, 1],
];

sub unequal_triplets
{
	my $l = shift;

	my $cnt = 0;
	my $iter = combinations([0 .. $#$l], 3);
    while (my $c = $iter->next) {
		my @v = $l->@[@$c];
        ++$cnt if $v[0] != $v[1] and $v[1] != $v[2] and $v[0] != $v[2];
    }

	return $cnt;
}

is(unequal_triplets($cases->[0]),  3, '[4, 4, 2, 4, 3]');
is(unequal_triplets($cases->[1]),  0, '[1, 1, 1, 1, 1]');
is(unequal_triplets($cases->[2]), 28, '[4, 7, 1, 10, 7, 4, 1, 1]');
done_testing();

exit 0;
