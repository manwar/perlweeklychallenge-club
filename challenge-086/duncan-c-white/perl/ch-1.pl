#!/usr/bin/perl
#
# Task 1: "Pair Difference
#
# You are given an array of integers @N and an integer $A.
# 
# Write a script to find find if there exists a pair of elements in the
# array whose difference is $A.  Print 1 if exists otherwise 0.
# 
# Example 1:
# 
# 	Input: @N = (10, 8, 12, 15, 5) and $A = 7
# 	Output: 1 as 15 - 8 = 7
# 
# Example 2:
# 
# 	Input: @N = (1, 5, 2, 9, 7) and $A = 6
# 	Output: 1 as 7 - 1 = 6
# 
# Example 3:
# 
# 	Input: @N = (10, 30, 20, 50, 40) and $A = 15
# 	Output: 0
# 
# My notes: simple and straightforward: try all pairs of elements looking
# for abs(x-y)==A
#

use strict;
use warnings;
use feature 'say';
use Function::Parameters;
use Data::Dumper;
use Getopt::Long;

my $debug = 0;
die "Usage: pair-diff [--debug] DIFF array\n" unless
	GetOptions( "debug" => \$debug ) &&
	@ARGV>1;
my( $diff, @x ) = @ARGV;

#
# my $found = finddiff( $diff, @x );
#	Attempt to find any two elements of @x with difference $diff;
#	return 1 iff such a pair of elements exists (0 otherwise).
#
fun finddiff( $diff, @x )
{
	foreach my $apos (0..$#x-1)
	{
		my $a = $x[$apos];
		foreach my $bpos ($apos+1..$#x)
		{
			my $b = $x[$bpos];
			next unless abs($a-$b) == $diff;
			say "found $a and $b with diff $diff" if $debug;
			return 1;
		}
	}
	return 0;
}


my $found = finddiff( $diff, @x );
say $found;
