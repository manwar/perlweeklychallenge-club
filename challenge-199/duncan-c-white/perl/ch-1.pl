#!/usr/bin/perl
# 
# Task 1: Good Pairs
# 
# You are given a list of integers, @list.
# 
# Write a script to find the total count of Good Pairs: A pair (i, j) is
# called good if list[i] == list[j] and i < j.
# 
# 
# Example 1
# 
# Input: @list = (1,2,3,1,1,3)
# Output: 4
# 
# There are 4 good pairs found as below:
# (0,3)
# (0,4)
# (3,4)
# (2,5)
# 
# Example 2
# 
# Input: @list = (1,2,3)
# Output: 0
# 
# Example 3
# 
# Input: @list = (1,1,1,1)
# Output: 6
# 
# Good pairs are below:
# (0,1)
# (0,2)
# (0,3)
# (1,2)
# (1,3)
# (2,3)
# 
# MY NOTES: very easy.  two nested for loops..
# 
# GUEST LANGUAGE: As a bonus, I also had a go at translating ch-1.pl
# into C (look in the C directory for the translation)
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Data::Dumper;

my $debug=0;
die "Usage: good-pairs [--debug] intlist\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV>0;

my @list = split( /,/, join(',',@ARGV) );

die "good-pairs: need at least 2 ints in list\n" unless @list>1;

my @result;

for( my $i=0; $i<@list; $i++ )
{
	for( my $j=$i+1; $j<@list; $j++ )
	{
		push @result, [$i,$j] if $list[$i] == $list[$j];
	}
}

say scalar(@result);

say "Good pairs are below:";
foreach my $p (@result)
{
	my( $i, $j ) = @$p;
	say "($i,$j)";
}
