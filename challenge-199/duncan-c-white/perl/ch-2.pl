#!/usr/bin/perl
# 
# Task 2: Good Triplets
# 
# You are given an array of integers, @array and three integers $x,$y,$z.
# 
# Write a script to find out total Good Triplets in the given array.
# 
# A triplet array[i], array[j], array[k] is good if it satisfies the following conditions:
# 
# a) 0 <= i < j < k <= n (size of given array)
# b) abs(array[i] - array[j]) <= x
# c) abs(array[j] - array[k]) <= y
# d) abs(array[i] - array[k]) <= z
# 
# Example 1
# 
# Input: @array = (3,0,1,1,9,7) and $x = 7, $y = 2, $z = 3
# Output: 4
# 
# Good Triplets are as below:
# (3,0,1) where (i=0, j=1, k=2)
# (3,0,1) where (i=0, j=1, k=3)
# (3,1,1) where (i=0, j=2, k=3)
# (0,1,1) where (i=1, j=2, k=3)
# 
# Example 2
# 
# Input: @array = (1,1,2,2,3) and $x = 0, $y = 0, $z = 1
# Output: 0
# 
# MY NOTES: not quite so easy, start with 3 nested for loops;-)
# 
# GUEST LANGUAGE: As a bonus, I also had a go at translating ch-2.pl
# into C (look in the C directory for the translation)
#

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Function::Parameters;
use Data::Dumper;

my $debug=0;
die "Usage: good-triplets [--debug] X,Y.and Z intlist\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV > 4;
my( $x, $y, $z, @list ) = @ARGV;

@list = split( /,/, join(',',@list) );

die "good-triples: need at least 3 ints in list\n" unless @list>2;

my @result;

for( my $i=0; $i<@list; $i++ )
{
	for( my $j=$i+1; $j<@list; $j++ )
	{
		next if abs($list[$i] - $list[$j]) > $x;
		for( my $k=$j+1; $k<@list; $k++ )
		{
			push @result, [$list[$i],$list[$j],$list[$k] ] if
				abs($list[$j] - $list[$k]) <= $y &&
				abs($list[$i] - $list[$k]) <= $z;
		}
	}
}

say scalar(@result);

if( @result )
{
	say "Good triples are below:";
	foreach my $p (@result)
	{
		my( $i, $j, $k ) = @$p;
		say "($i,$j,$k)";
	}
}
