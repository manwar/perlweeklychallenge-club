#!/usr/bin/env perl
#
# You are given an array of integers, @ints and a target element $k.
#
# Write a script to return the list of indices in the sorted array where the
# element is same as the given target element.
# Example 1
# 
# Input: @ints = (1, 5, 3, 2, 4, 2), $k = 2
# Output: (1, 2)
# 
# Sorted array: (1, 2, 2, 3, 4, 5)
# Target indices: (1, 2) as $ints[1] = 2 and $k[2] = 2
# 
# Example 2
# 
# Input: @ints = (1, 2, 4, 3, 5), $k = 6
# Output: ()
# 
# No element in the given array matching the given target.
# 
# Example 3
# 
# Input: @ints = (5, 3, 2, 4, 2, 1), $k = 4
# Output: (4)
# 
# Sorted array: (1, 2, 2, 3, 4, 5)
# Target index: (4) as $ints[4] = 4
# 

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
	[[[1, 5, 3, 2, 4, 2], 2], [1, 2], 'Example 1'],
	[[[1, 2, 4, 3, 5],    6], [],     'Example 2'],
	[[[5, 3, 2, 4, 2, 1], 4], [4],    'Example 3'],
];

sub target_index
{
	my $l = $_->[0]->[0];
	my $k = $_->[0]->[1];
	
	my @l = sort {$a <=> $b} @$l;
	my @res;
	
	my $found;
	for (0..$#l) {
	    if ($l[$_] == $k) {
			push @res, $_;
			$found = 1;
		} elsif ($found) {
			last;
		}
	}
	return \@res;
}

for (@$cases) {
    is(target_index($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
