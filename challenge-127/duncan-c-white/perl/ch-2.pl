#!/usr/bin/perl
# 
# Task 2: "Conflict Intervals
# 
# You are given a list of intervals.
# 
# Write a script to find out if the current interval conflicts with any
# of the previous intervals.
# 
# Example
# 
# Input: @Intervals = [ (1,4), (3,5), (6,8), (12, 13), (3,20) ]
# Output: [ (3,5), (3,20) ]
# 
#     - The 1st interval (1,4) have no previous intervals to compare, skip it.
#     - The 2nd interval (3,5) conflicts with previous interval (1,4).
#     - The 3rd interval (6,8) does not conflict with any of the previous
#       intervals (1,4) and (3,5), so skip it.
#     - The 4th interval (12,13) again does not conflict with any of the
#       previous intervals (1,4), (3,5) and (6,8), so skip it.
#     - The 5th interval (3,20) conflicts with the first interval (1,4).
# 
# Input: @Intervals = [ (3,4), (5,7), (6,9), (10, 12), (13,15) ]
# Output: [ (6,9) ]
# 
#     - The 1st interval (3,4) has no previous intervals to compare, skip it.
#     - The 2nd interval (5,7) does not conflict with the previous interval
#       (3,4), so skip it.
#     - The 3rd interval (6,9) does conflict with one of the previous intervals
#       (5,7).
#     - The 4th interval (10,12) do not conflicts with any of the previous
#       intervals (3,4), (5,7) and (6,9), so skip it.
#     - The 5th interval (13,15) do not conflicts with any of the previous
#       intervals (3,4), (5,7), (6,9) and (10,12), so skip it.
# "
# 
# My notes: also looks pretty easy.  I think "conflict" means "overlap".
# 
# 

use strict;
use warnings;
use feature 'say';
use Function::Parameters;
use Getopt::Long;
use Data::Dumper;

my $debug = 0;

die "Usage: overlap [-d|--debug] list(from,to) pairs\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV>0;
my @overlap = overlap( @ARGV );
say join(' ',@overlap);


#
# my @overlap = overlap( @pair );
#	Determine whether any of @pair intervals overlap;
#	return a list of those that do overlap.
#
fun overlap( @pair )
{
	my @line;
	my @result;
	foreach my $xy (@pair)
	{
		my( $a, $b  ) = split(/,/,$xy);
		my $add = 0;
		foreach my $pos ($a..$b)
		{
			$add++ if $line[$pos];
			$line[$pos] = 1;
		}
		push @result, $xy if $add;
	}
	return @result;
}
