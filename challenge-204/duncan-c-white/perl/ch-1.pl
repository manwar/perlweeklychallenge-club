#!/usr/bin/perl
# 
# Task 1: Monotonic Array
# 
# You are given an array of integers.
# 
# Write a script to find out if the given array is Monotonic. Print 1 if
# it is otherwise 0.
# 
# An array is Monotonic if it is either monotone increasing or decreasing.
# 
# Monotone increasing: for i <= j , nums[i] <= nums[j]
# Monotone decreasing: for i <= j , nums[i] >= nums[j]
# 
# Example 1
# 
#   Input: @nums = (1,2,2,3)
#   Output: 1
# 
# Example 2
# 
#   Input: @nums = (1,3,2)
#   Output: 0
# 
# Example 3
# 
#   Input: @nums = (6,5,5,4)
#   Output: 1
# 
# MY NOTES: seems very easy. use reverse() in order not to detect
# monotonically increasing and decreasing..
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
die "Usage: monotonic-array [--debug] intlist\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV>0;

=pod

=head2 my $ismon = ismonotonic( @list );

Return 1 iff @list is monotonically increasing, ie.
for i <= j , nums[i] <= nums[j].  Else return 0.

=cut
sub ismonotonic
{
	my( @list ) = @_;
	foreach my $a (0..$#list-1)
	{
		foreach my $b ($a+1..$#list)
		{
			return 0 if $list[$a] > $list[$b];
		}
	}
	return 1;
}


my @list = split( /,/, join(',',@ARGV) );

die "monotonic-array: need at least 2 ints in list\n" unless @list>1;

my $ismon = ismonotonic( @list );
$ismon |= ismonotonic( reverse @list );
say $ismon;
