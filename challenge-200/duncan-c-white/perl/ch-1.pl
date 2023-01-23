#!/usr/bin/perl
# 
# Task 1: Arithmetic Slices
# 
# You are given an array of integers.
# 
# Write a script to find out all Arithmetic Slices for the given array
# of integers.  An integer array is called arithmetic if it has at least
# 3 elements and the differences between any three consecutive elements
# are the same.
# 
# 
# Example 1
# 
# Input: @array = (1,2,3,4)
# Output: (1,2,3), (2,3,4), (1,2,3,4)
# 
# Example 2
# 
# Input: @array = (2)
# Output: () as no slice found.
# 
# 
# MY NOTES: pretty easy.  generate and test: generate all subarrays of len > 2
# via two nested for loops.  then test for all-elements-one-apart.  (Actually,
# that's not quite what the spec said, but I noticed that too late).
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
die "Usage: arithmetic-slices [--debug] intlist\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV>0;

my @list = split( /,/, join(',',@ARGV) );

die "arithmetic-slices: need at least 3 ints in list\n" unless @list>2;

my @result;

sub isarith
{
	my( @a ) = @_;
	die "need at least 3 elements in @a\n", if @a<3;
	my $v = shift @a;
	foreach my $e (@a)
	{
		$v++;
		return 0 unless $e == $v;
	}
	return 1;
}


for( my $i=0; $i<@list-2; $i++ )
{
	for( my $j=$i+2; $j<@list; $j++ )
	{
		my @sub = @list[$i..$j];
		say "debug: sub($i,$j)=". join(',',@sub) if $debug;
		push @result, \@sub if isarith(@sub);
	}
}

say "Results:";
foreach my $p (@result)
{
	say "(".join(',',@$p).")";
}
