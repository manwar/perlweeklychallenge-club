#!/usr/bin/perl
# 
# Task 1: "Maximum Gap
# 
# You are given an array of integers @N.
# 
# Write a script to display the maximum difference between two successive
# elements once the array is sorted.
# If the array contains only 1 element then display 0.
# 
# Example
# 
# 	Input: @N = (2, 9, 3, 5)   [sorted: 2 3 5 9]
# 	Output: 4
# 
# 	Input: @N = (1, 3, 8, 2, 0) [sorted: 0 1 2 3 8]
# 	Output: 5
# 
# 	Input: @N = (5)
# 	Output: 0
# "
# 
# My notes: should be easy.
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
#use Data::Dumper;

my $debug=0;
die "Usage: maxgap [--debug] N1 N2...\n"
	unless GetOptions( "debug" => \$debug ) && @ARGV>0;

my @n = sort { $a <=> $b } @ARGV;

say "0" if @n==1;

if( @n > 1 )
{
	my $maxdiff = 0;
	foreach my $i (0..$#n-1)
	{
		$a = $n[$i];
		$b = $n[$i+1];
		my $diff = $b-$a;
		$maxdiff = $diff if $diff > $maxdiff;
	}
	say $maxdiff;
}
