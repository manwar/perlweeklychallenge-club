#!/usr/bin/perl
# 
# TASK #1 - JortSort
# 
# You are given a list of numbers.
# 
# Write a script to implement JortSort. It should return true/false
# depending if the given list of numbers are already sorted.
# 
# Example 1:
# 
# 	Input: @n = (1,2,3,4,5)
# 	Output: 1
# 
# 	Since the array is sorted, it prints 1.
# 
# Example 2:
# 
# 	Input: @n = (1,3,2,4,5)
# 	Output: 0
# 
# 	Since the array is NOT sorted, it prints 0.
# 
# MY NOTES: Very easy.  Don't know what "JortSort" means, but this is
# just the linear "IsSorted" function..
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Function::Parameters;
#use Data::Dumper;


my $debug=0;
die "Usage: is-sorted list(numbers)\n" unless
	GetOptions( "debug"=>\$debug ) && @ARGV>0;

#
# my $issorted = issorted( @a );
#	Return 1 iff @a is already sorted.  0 otherwise.
#
fun issorted( @a )
{
	foreach my $i (0..$#a-1)
	{
		return 0 if $a[$i] > $a[$i+1];
	}
	return 1;
}


my @x = @ARGV;
my $issorted = issorted( @x );
say $issorted;
