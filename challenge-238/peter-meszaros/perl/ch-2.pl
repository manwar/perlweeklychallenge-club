#!/usr/bin/env perl
#
# You are given an array of positive integers.
# 
# Write a script to sort the given array in increasing order with respect to
# the count of steps required to obtain a single-digit number by multiplying its
# digits recursively for each array element. If any two numbers have the same
# count of steps, then print the smaller number first.
# Example 1
# 
# Input: @int = (15, 99, 1, 34)
# Output: (1, 15, 34, 99)
# 
# 15 => 1 x 5 => 5 (1 step)
# 99 => 9 x 9 => 81 => 8 x 1 => 8 (2 steps)
# 1  => 0 step
# 34 => 3 x 4 => 12 => 1 x 2 => 2 (2 steps)
# 
# Example 2
# 
# Input: @int = (50, 25, 33, 22)
# Output: (22, 33, 50, 25)
# 
# 50 => 5 x 0 => 0 (1 step)
# 25 => 2 x 5 => 10 => 1 x 0 => 0 (2 steps)
# 33 => 3 x 3 => 6 (1 step)
# 22 => 2 x 2 => 4 (1 step)
# 

use strict;
use warnings;
use Test::More;
use Data::Dumper;

my $cases = [
	[15, 99, 1, 34],
	[50, 25, 33, 22],
];

sub count_steps
{
	my $n = shift;

	my $steps = 0;
	while(length($n)> 1) {
		++$steps;
		my @n = split('', $n);
		$n = 1;
		$n *= $_ for @n;
	}
	return $steps;
}

sub persistence_sort
{
	my $l = shift;
	
	my @steps = map { count_steps($_) } @$l;

	my @ord = sort { if ($steps[$a] == $steps[$b]) {
					     return $l->[$a] <=> $l->[$b];
					 }
					 return $steps[$a] <=> $steps[$b]
                   } (0 .. $#$l);
	
	return [$l->@[@ord]];
}

is_deeply(persistence_sort($cases->[0]), [1, 15, 34, 99],  '[15, 99, 1, 34]');
is_deeply(persistence_sort($cases->[1]), [22, 33, 50, 25], '[50, 25, 33, 22]');
done_testing();

exit 0;
