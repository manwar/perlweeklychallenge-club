#!/usr/bin/perl
# 
# Task 1: "Ugly Numbers
# 
# You are given an integer $n >= 1.
# 
# Write a script to find the $nth element of Ugly Numbers.
# 
# Ugly numbers are those number whose prime factors are 2, 3 or 5.
# For example, the first 10 Ugly Numbers are 1, 2, 3, 4, 5, 6, 8, 9, 10, 12.
# 
# Example
# 
# 	Input: $n = 7
# 	Output: 8
# 
# 	Input: $n = 10
# 	Output: 12
# "
# 
# My notes: sounds quite simple.  I thought of digging out primes and
# factors code from previous PWCs, but the only primes we care about are
# 2, 3 and 5.
# 

use strict;
use warnings;
use feature 'say';
use Function::Parameters;
#use Data::Dumper;

die "Usage: ugly-number N\n" unless @ARGV == 1;
my $n = shift;
die "ugly-number: N ($n) must be >= 1\n" if $n<1;

my $x = nth_ugly( $n );
say $x;


#
# my $ugly = isugly( $x );
#	Return 1 iff $x is ugly; return 0 otherwise.
#
fun isugly( $x )
{
	return 0 if $x < 1;
	while( $x % 5 == 0 ) { $x /= 5 }
	while( $x % 3 == 0 ) { $x /= 3 }
	while( $x % 2 == 0 ) { $x /= 2 }
	return $x==1 ? 1 : 0;
}


#
# my $x = nth_ugly( $n );
#	Determine and result $x, the $n-th ugly number.
#
fun nth_ugly( $n )
{
	for( my $i=1; ; $i++ )
	{
		if( isugly($i) )
		{
			if( --$n==0 )
			{
				return $i;
			}
		}
	}
}
