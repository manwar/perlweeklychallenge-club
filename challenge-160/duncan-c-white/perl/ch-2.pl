#!/usr/bin/perl
# 
# TASK #2 - Equilibrium Index
# 
# You are give an array of integers, @n.
# 
# Write a script to find out the Equilibrium Index of the given array, if found.
# 
# For an array A consisting n elements, index i is an equilibrium index
# if the sum of elements of subarray A[0..i-1] is equal to the sum of
# elements of subarray A[i+1..n-1].
# 
# Example 1:
# 
# 	Input: @n = (1, 3, 5, 7, 9)
# 	Output: 3
# 
# Example 2:
# 
# 	Input: @n = (1, 2, 3, 4, 5)
# 	Output: -1 as no Equilibrium Index found.
# 
# Example 3:
# 
# 	Input: @n = (2, 4, 2)
# 	Output: 1
# 
# MY NOTES: ok.  Pretty easy.  Rather than recomputing sums each time,
# let's keep track of "the sum before i" and "the sum after i" and
# adjust them each pass..
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use List::Util qw(sum0);
use Function::Parameters;
#use Data::Dumper;

my $debug=0;
die "Usage: equilibrium-index [--debug] numeric values\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV>2;

my @n = @ARGV;
my $equiindex = equi_index( @n );
say $equiindex;

#
# my $equiindex = equi_index( @n );
#	Return the equi index (as defined above) of @n,
#	if there is one, or -1 if there isn't.
#
fun equi_index( @n )
{
	my $sumafter = sum0( @n ) - $n[0] - $n[1];
	my $sumbefore = $n[0];
	foreach my $i (1..$#n-1)
	{
		say "i=$i, sumbefore=$sumbefore, sumafter=$sumafter, add=$n[$i], sub=$n[$i+1]" if $debug;
		return $i if $sumbefore == $sumafter;
		$sumbefore += $n[$i];
		$sumafter  -= $n[$i+1];
	}
	return -1;
}
