#!/usr/bin/perl
#
# Task 2: "Power of Two Integers
# 
# You are given a positive integer $N.
# 
# Write a script to find if it can be expressed as a ** b where a > 0 and
# b > 1. Print 1 if you succeed otherwise 0.
# 
# Example 1:
# 
# Input: 8
# Output: 1 as 8 = 2 ** 3
# 
# Example 2:
# 
# Input: 15
# Output: 0
# 
# Example 3:
# 
# Input: 125
# Output: 1 as 125 = 5 ** 3
# 
# My notes: clearly defined, not quite sure how to do it so.. let's brute force
# 

use strict;
use warnings;
use feature 'say';
use Function::Parameters;
use Data::Dumper;

die "Usage: power N\n" unless @ARGV==1;
my $n = shift;

#
# my $isatob = atob( $n );
#	Return 1 iff $n if a**b where a>0 && b>1
#
fun atob( $n )
{
	return 1 if $n==1;
	my $limit = int(sqrt($n));
	foreach my $a (2..$limit)
	{
		next unless $n % $a == 0;
		my $x = $n/$a;
		while( $x>1 && $x % $a == 0 )
		{
			$x /= $a;
		}
		return 1 if $x==1;
	}
	return 0;
}


my $result = atob( $n );
say $result;

