#!/usr/bin/perl
#
# Task 2: Split Same Average
# 
# You are given an array of integers.  Write a script to find out if the
# given can be split into two separate arrays whose average are the same.
# 
# Example 1:
# 
#   Input: @nums = (1, 2, 3, 4, 5, 6, 7, 8)
#   Output: true
# 
#   We can split the given array into (1, 4, 5, 8) and (2, 3, 6, 7).
#   The average of the two arrays are the same i.e. 4.5.
# 
# Example 2:
# 
#   Input: @list = (1, 3)
#   Output: false
# 
# MY NOTES: sounds easy enough as a brute force search.
# First observation: the "average of each sub-array" (our goal) must be
# the overall average, as that's the only way the sub-array averages can be
# the same value.
# Second observation: each element is either in the first subarray or in the
# second subarray, a binary counting approach is the obvious brute force method.
# (Note: I last did this in challenge 136, task 2, when we were summing subsets
# of Fibonacci numbers, so I've reused a little code from there).
# Third observation: we need only check one of the two sub-arrays (eg the first)
# as having the right sub-array average - the overall average.
# 
# GUEST LANGUAGE: As a bonus, I also had a go at translating ch-2.pl into C
# (look in the C directory for that)
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Data::Dumper;
use Function::Parameters;
use List::Util qw(sum0);

my $debug=0;
die "Usage: split-sum-average [--debug] intlist\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV > 0;

my @list = split( /,/, join(',',@ARGV) );

say "list: ", join(',',@list) if $debug;

#
# my( $sel, $notsel ) = count_val_avg( $goalavg, @val );
#	Attempt to find a subset of @val whose average is $goalavg.
#	If we find one, return a reference to the array of matching elements
#	and a reference to the array of not-matching elements.
#	If we can't find one, return ().
#	Do it by iterating over all D-bit binary numbers from 1..2**D-2
#	(where D is the length(@val), subset-summing each combination
#
fun count_val_avg( $goalavg, @val )
{
	my $d = 2**@val-1;
	if( $debug )
	{
		say "debug: nval = ". scalar(@val). ", d = $d";
	}
	for( my $comb=1; $comb<$d; $comb++ )
	{
		my( $sum, $sel, $notsel ) = subset_sum( $comb, @val );
		if( $debug )
		{
			printf( "debug: selecting comb=$comb, ".
				"nsel=%d, nnotsel=%d",
				scalar(@$sel), scalar(@$notsel) );
			printf( ", selected = ". join(', ',@$sel) );
		}
		if( $sum==0 )
		{
			say " : rejected" if $debug;
			next;
		}
		my $avg = $sum / @$sel;
		say ", sum=$sum, avg=$avg" if $debug;
		return ( $sel, $notsel ) if $avg == $goalavg;
	}
	return ();
}


#
# my( $sum, $sel, $notsel ) = subset_sum( $comb, @val );
#	Consider $comb in binary, with as many bits as @val has
#	elements.  Sum up just the values in @vol whose corresponding
#	bit in $comb is 1, and return the sum, a reference to the
#	selected elements, and a reference to the NON-selected elements.
#
fun subset_sum( $comb, @val )
{
	my $sum = 0;
	my @selected;
	my @notselected;
	foreach my $val (@val)
	{
		if( $comb%2 == 1 )
		{
			$sum += $val;
			push @selected, $val;
		} else
		{
			push @notselected, $val;
		}
		$comb = int($comb/2);
	}
	return ( $sum, \@selected, \@notselected );
}


my $goalavg = sum0(@list)/@list;

say "goal average is $goalavg" if $debug;

my @pair = count_val_avg( $goalavg, @list );
if( @pair )
{
	if( $debug )
	{
		my( $sel, $notsel ) = @pair;
		say "found subset1 ", join(',',@$sel),
		    " and subset2 ", join(',',@$notsel);
	}
	say "true";
} else
{
	say "no subsets found" if $debug;
	say "false";
}
