#!/usr/bin/perl
#
# Task 2: "Flip Array
#
# You are given an array @A of positive numbers.
# 
# Write a script to flip the sign of some members of the given array so
# that the sum of the all members is minimum non-negative.
# 
# Given an array of positive elements, you have to flip the sign of some
# of its elements such that the resultant sum of the elements of array
# should be minimum non-negative(as close to zero as possible). Return
# the minimum no. of elements whose sign needs to be flipped such that
# the resultant sum is minimum non-negative.
# 
# Example 1:
# 	Input: @A = (3, 10, 8)
# 	Output: 1
# 
# Explanation:
# 
# Flipping the sign of just one element 10 gives the result 1 i.e. (3) +
# (-10) + (8) = 1
# 
# Example 2:
# 	Input: @A = (12, 2, 10)
# 	Output: 1
# 
# Explanation:
# 
# Flipping the sign of just one element 12 gives the result 0 i.e. (-12) +
# (2) + (10) = 0
# 
# My notes: clearly defined, but how to go about this one? several
# possible approaches.  brute force: each element may either be
# negated or not; try all combinations:-)  not very elegant, but does
# the job..
# 

use strict;
use warnings;
use feature 'say';
use Function::Parameters;
use List::Util 'sum';
use Data::Dumper;

die "Usage: negate-array-elements list_of_numbers\n" unless @ARGV;
my @a = @ARGV;

#
# my( $minsum, $minswaps ) = tryall( @a );
#	Try summing all elements of @a, with each element
#	as is or negated.  For each combination, sum the elements,
#	count the number of negations, and keep track of $minsum -
#	the minimum sum - and $minswaps - the minimum number of negations.
#	Return the final pair ($minsum, $minswaps).
#
fun tryall( @a )
{
	# first pass: build @sum, @swaps and find min sum
	my $n = @a;
	my $limit = 2**$n;
	my @swaps;
	my @sum;
	my $minsum = sum(@a);
	foreach my $i (0..$limit-1)
	{
		my $binary = sprintf( "%0${n}b", $i );
		#say "binary=$binary";

		my $sum = 0;
		my $swaps = 0;
		foreach my $pos (0..$n-1)
		{
			my $x = $a[$pos];
			if( substr($binary,$pos,1) eq '1' )
			{
				$x = -$x;
				$swaps++;
			}
			$sum += $x;
		}
		push @sum, $sum;
		push @swaps, $swaps;
		#say "sum=$sum";
		next if $sum < 0;
		if( $sum <= $minsum )
		{
			$minsum = $sum;
		}
	}

	#say "minsum: $minsum";

	# second pass: find minswaps giving EXACTLY minsum
	my $minswaps = @a+1;

	foreach my $i (0..$limit-1)
	{
		next unless $sum[$i] == $minsum;
		my $swaps = $swaps[$i];
		$minswaps = $swaps if $swaps < $minswaps;
	}

	return ($minsum, $minswaps);
}


my( $minsum, $minswaps ) = tryall( @a );
say "minsum=$minsum, minswaps=$minswaps";
