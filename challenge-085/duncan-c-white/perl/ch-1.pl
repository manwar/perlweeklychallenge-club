#!/usr/bin/perl
#
# Task 1: "Triplet Sum
#
# You are given an array of real numbers greater than zero.
# 
# Write a script to find if there exists a triplet (a,b,c) such that 1 <
# a+b+c < 2. Print 1 if you succeed otherwise 0.
# 
# Example 1:
# 
# 	Input: @R = (1.2, 0.4, 0.1, 2.5)
# 	Output: 1 as 1 < 1.2 + 0.4 + 0.1 < 2
# 
# Example 2:
# 
# 	Input: @R = (0.2, 1.5, 0.9, 1.1)
# 	Output: 0
# 
# Example 3:
# 
# 	Input: @R = (0.5, 1.1, 0.3, 0.7)
# 	Output: 1 as 1 < 0.5 + 1.1 + 0.3 < 2
# 
# My notes: simple, I think it means "pick any 3 elements a, b and c from the
# array and determine if any a,b,c triple sums to between 1 and 2", although
# both successful examples show 3 ADJACENT elements a, b and c...
#

use strict;
use warnings;
use feature 'say';
use Function::Parameters;
use Data::Dumper;

die "Usage: triplet-sum array\n" unless @ARGV;
my @x = @ARGV;

#
# my $istriplet = findtriplet( @x );
#	Find whether the sum of any triplet of elements from @x
#	has a sum between 1 and 2.  Return 1 iff one does; return 0 otherwise.
#
fun findtriplet( @x )
{
	my $n = @x;
	foreach my $apos (0..$n-3)
	{
		my $a = $x[$apos];
		foreach my $bpos ($apos+1..$n-2)
		{
			my $b = $x[$bpos];
			foreach my $cpos ($bpos+1..$n-1)
			{
				my $c = $x[$cpos];
				my $sum = $a+$b+$c;
				return 1 if $sum > 1 && $sum < 2;
			}
		}
	}
	return 0;
}

my $istriplet = findtriplet( @x );
say $istriplet;
