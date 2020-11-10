#!/usr/bin/perl
#
# Task 2: "Find Square
#
# You are given a binary matrix of size m x n (all elements are 1 or 0).
# 
# Write a script to find the count of squares having all four corners set as 1.
# 
# Example 1:
# 
# Input: [ 0 1 0 1 ]
#        [ 0 0 1 0 ]
#        [ 1 1 0 1 ]
#        [ 1 0 0 1 ]
# 
# Output: 1
# 
# Explanation:
# 	There is one square (3x3) in the given matrix with four corners
# 	as 1 starts at r=1;c=2.
# 
# 	[ 1 0 1 ]
# 	[ 0 1 0 ]
# 	[ 1 0 1 ]
# 
# Example 2:
# 
# Input: [ 1 1 0 1 ]
#        [ 1 1 0 0 ]
#        [ 0 1 1 1 ]
#        [ 1 0 1 1 ]
# 
# Output: 4
# 
# Explanation:
# 	There is one square (4x4) in the given matrix with four corners
# 	as 1 starts at r=1;c=1.
# 	There is one square (3x3) in the given matrix with four corners as 1
# 	starts at r=1;c=2.
# 	There are two squares (2x2) in the given matrix with four corners as
# 	1. First starts at r=1;c=1 and second starts at r=3;c=3.
# 
# Example 3:
# 
# Input: [ 0 1 0 1 ]
#        [ 1 0 1 0 ]
#        [ 0 1 0 0 ]
#        [ 1 0 0 1 ]
# 
# Output: 0
# 
# My notes: clearly defined, seems straightforward.
#
# Input format: CSV rows on command line so example 3 is:
# ./ch-2.pl 0,1,0,1 1,0,1,0 0,1,0,0 1,0,0,1
#
# This is my second attempt, where I found all SQUARES inside the
# matrix (rather than all RECTANGLES, checking which were squares)
# reduces 4 nested loops to 3..

use strict;
use warnings;
use feature 'say';
use Function::Parameters;
use List::Util 'min';
use Data::Dumper;

die "Usage: count-squares list_of_csvrows\n" unless @ARGV;
my @m;
foreach my $row (@ARGV)
{
	my @r = split(/,/, $row);
	push @m, \@r;
}
#say Dumper(\@m);

my $rows = @m;
my $cols = @{$m[0]};

my $nsquares = 0;
foreach my $startr (0..$rows-2)
{
	foreach my $startc (0..$cols-2)
	{
		next unless $m[$startr][$startc] == 1;
		for( my $w=1; ; $w++ )
		{
			my $endc = $startc + $w;
			last if $endc >= $cols;

			my $endr = $startr + $w;
			last if $endr >= $rows;

			next unless $m[$startr][$endc] == 1;
			next unless $m[$endr][$startc] == 1;
			next unless $m[$endr][$endc] == 1;
			$nsquares++;
			#say "found 1-square: sr=$startr, sc=$startc, er=$endr, ec=$endc";
		}
	}
}

say $nsquares;
