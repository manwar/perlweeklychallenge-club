#!/usr/bin/perl
# 
# Task 2: "Sum of Squares
# 
# You are given a number $N >= 10.
# 
# Write a script to find out if the given number $N is such that sum of
# squares of all digits is a perfect square. Print 1 if it is otherwise 0.
# 
# Example
# 
#   Input: $N = 34
#   Ouput: 1 as 3^2 + 4^2 => 9 + 16 => 25 => 5^2
# 
#   Input: $N = 50
#   Output: 1 as 5^2 + 0^2 => 25 + 0 => 25 => 5^2
#   
#   Input: $N = 52
#   Output: 0 as 5^2 + 2^2 => 25 + 4 => 29
# "
# 
# My notes: should be easy.
# 

use strict;
use warnings;
use feature 'say';
use List::Util qw(sum);
use Function::Parameters;
#use Data::Dumper;

die "Usage: sum-of-squares N\n" unless @ARGV==1;
my $n = shift;

die "$n must be >= 10\n" if $n < 10;
my $sumsq = issumsq( $n );
say $sumsq;


#
# my $isperfect = isperfectsquare($n);
#	Return 1 iff $n is a perfect square, 0 otherwise.
#
fun isperfectsquare( $n )
{
	for( my $i=0; $i*$i<=$n; $i++ )
	{
		return 1 if $i*$i==$n;
	}
	return 0;
}


#
# my $sumsq = issumsq( $n );
#	Solve the problem as stated.
#
fun issumsq( $n )
{
	my $ssq = sum( map { $_ * $_ } split(//,$n) );
	return 1 if isperfectsquare($ssq);
	return 0;
}


