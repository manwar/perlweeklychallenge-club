#!/usr/bin/perl
# 
# Task 1: Divisible Pairs
# 
# You are given list of integers @list of size $n and divisor $k.
# 
# Write a script to find out count of pairs in the given list that satisfies
# the following rules.
# 
# The pair (i, j) is eligible if and only if
# a) 0 <= i < j < len(list)
# b) list[i] + list[j] is divisible by k
# 
# Example 1
# 
# 	Input: @list = (4, 5, 1, 6), $k = 2
# 	Output: 2
# 
# Example 2
# 
# 	Input: @list = (1, 2, 3, 4), $k = 2
# 	Output: 2
# 
# Example 3
# 
# 	Input: @list = (1, 3, 4, 5), $k = 3
# 	Output: 2
# 
# Example 4
# 
# 	Input: @list = (5, 1, 2, 3), $k = 4
# 	Output: 2
# 
# Example 5
# 
# 	Input: @list = (7, 2, 4, 5), $k = 4
# 	Output: 1
# 
# MY NOTES: pretty easy.  Generate all pairs of indices, and test each pair
# for property (2).
# 
# GUEST LANGUAGE: As a bonus, I also had a go at translating ch-1.pl
# into C (look in the C directory for that).
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Data::Dumper;


my $debug=0;
die "Usage: divisible-pairs [--debug] k list(int)\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV>2;


my( $k, @list ) = @ARGV;
@list = split( /\s*,\s*/, join(',',@list) );
say "debug: k=$k, list=", join(',',@list) if $debug;

my $found = 0;

foreach my $i (0..$#list-1)
{
	foreach my $j ($i+1..$#list)
	{
		next unless ($list[$i] + $list[$j] ) % $k == 0;
		say "found pair $i, $j (elements $list[$i], $list[$j])" if $debug;
		$found++;
	}
}
say $found;
