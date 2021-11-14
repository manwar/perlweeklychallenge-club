#!/usr/bin/perl
# 
# TASK #2 - Fibonacci Sequence
# 
# You are given a positive number $n.
# 
# Write a script to find how many different sequences you can create using
# Fibonacci numbers where the sum of unique numbers in each sequence are
# the same as the given number.
# 
#     Fibonacci Numbers: 1,2,3,5,8,13,21,34,55,89,..
# 
# Example 1
# 
#   Input:  $n = 16
#   Output: 4
# 
#   Reason: There are 4 possible sequences that can be created using Fibonacci numbers
#   i.e. (3 + 13), (1 + 2 + 13), (3 + 5 + 8) and (1 + 2 + 5 + 8).
# 
# Example 2
# 
#   Input:  $n = 9
#   Output: 2
# 
#   Reason: There are 2 possible sequences that can be created using Fibonacci numbers
#   i.e. (1 + 3 + 5) and (1 + 8).
# 
# Example 3
# 
#   Input:  $n = 15
#   Output: 2
# 
#   Reason: There are 2 possible sequences that can be created using Fibonacci numbers
#   i.e. (2 + 5 + 8) and (2 + 13).
# 
# MY NOTES: Pretty easy - find subsets of the first few Fibonacci numbers that sum to N.
# How many Fibonacci numbers should we consider?  Those <= N.
# 

use strict;
use warnings;
use feature 'say';
use Function::Parameters;
use Getopt::Long;
use Data::Dumper;

my $debug = 0;

die "Usage: count-fib [-d|--debug] N\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV==1;
my $n = shift @ARGV;

#
# my @fib = fibs_upto( $n );
#	Find Fibonacci numbers up to $n.
#
fun fibs_upto( $n )
{
	my @result;
	my( $a, $b ) = ( 1, 1 );
	while( $a <= $n )
	{
		push @result, $a;
		( $a, $b ) = ( $b, $a+$b );
	}
	return @result;
}


#
# my @subsets = count_val_sum( $n, @val );
#	Find all distinct subsets of @val total to $n, and
#	and return an array of all such subsets.  Do it by
#	iterating over all D-bit binary numbers from 1..2**D-1
#	(where D is the length(@val), subset-summing each combination
#
fun count_val_sum( $n, @val )
{
	my $digits = 2**@val;
	my @result;
	for( my $comb=1; $comb<$digits; $comb++ )
	{
		my( $sum, @selected ) = subset_sum( $comb, @val );
		next unless $sum == $n;
		push @result, \@selected;
	}
	return @result;
}


#
# my( $sum, @selected ) = subset_sum( $comb, @val );
#	Consider $comb in binary, with as many bits as @val has
#	elements.  Sum up just the values in @vol whose corresponding
#	bit in $comb is 1, and return the sum and the selected values.
#
fun subset_sum( $comb, @val )
{
	my $sum = 0;
	my @selected;
	foreach my $val (@val)
	{
		if( $comb%2 == 1 )
		{
			$sum += $val;
			push @selected, $val;
		}
		$comb = int($comb/2);
	}
	return ( $sum, @selected );
}


my @fib = fibs_upto( $n );
shift @fib;			# remove duplicate 1
#say Dumper(\@fib);

my @subsets = count_val_sum( $n, @fib );
my $count = @subsets;

say "Output: $count";
say "\nReason: the following $count subsets sum to $n";
say join(',',@$_) for @subsets;
