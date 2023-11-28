#!/usr/bin/env perl
#
# You are given an array of integers >= 0.
# 
# Write a script to return the largest number formed by concatenating some of
# the given integers in any order which is also multiple of 3. Return -1 if none
# found.
# 
# Example 1
# 
# Input: @ints = (8, 1, 9)
# Output: 981
# 
# 981 % 3 == 0
# 
# Example 2
# 
# Input: @ints = (8, 6, 7, 1, 0)
# Output: 8760
# 
# Example 3
# 
# Input: @ints = (1)
# Output: -1
# 

use strict;
use warnings;
use Test::More;
use Data::Dumper;
use Algorithm::Combinatorics qw/variations/;

my $cases = [
	[8, 1, 9],
	[8, 6, 7, 1, 0],
	[1],
];

sub largest_of_three
{
	my $l = shift;

	my $num = -1;
    my @l;
	for my $k (1..(scalar @$l)) {
		my $iter = variations($l, $k);
		while (my $p = $iter->next) {
			push @l, 0+join('', @$p);
		}
	}

    for my $n (sort {$b <=> $a} @l) {
		if ($n % 3 == 0) {
			$num = $n;
			last;
		}
	}

    return $num;
}

is(largest_of_three($cases->[0]),  981, '[8, 1, 9]');
is(largest_of_three($cases->[1]), 8760, '[8, 6, 7, 1, 0]');
is(largest_of_three($cases->[2]),   -1, '[1]');
done_testing();

exit 0;
