#!/usr/bin/env perl
#
# You are given an array of integers.
# 
# Write a script to create an array such that new[i] = old[old[i]] where
# 0 <= i < new.length.
#
# Example 1
# 
# Input: @int = (0, 2, 1, 5, 3, 4)
# Output: (0, 1, 2, 4, 5, 3)
# 
# Example 2
# 
# Input: @int = (5, 0, 1, 2, 3, 4)
# Output: (4, 5, 0, 1, 2, 3)
# 

use strict;
use warnings;
use Test::More;
use Data::Dumper;

my $cases = [
	[0, 2, 1, 5, 3, 4],
	[5, 0, 1, 2, 3, 4],
];

sub build_array
{
	my $old = shift;

	my @ret;
	for (my $i=0; $i < @$old; ++$i) {
		push @ret, $old->[$old->[$i]];
	}

	return \@ret;
}

is_deeply(build_array($cases->[0]), [0, 1, 2, 4, 5, 3],  '[0, 2, 1, 5, 3, 4]');
is_deeply(build_array($cases->[1]), [4, 5, 0, 1, 2, 3],  '[5, 0, 1, 2, 3, 4]');
done_testing();

exit 0;
