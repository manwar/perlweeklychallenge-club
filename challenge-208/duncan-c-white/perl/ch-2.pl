#!/usr/bin/perl
#
# Task 2: Duplicate and Missing
# 
# You are given an array of integers in sequence with one missing and one
# duplicate.  Write a script to find the duplicate and missing integer in
# the given array. Return -1 if none found.  For the sake of this task,
# let us assume the array contains no more than one duplicate and missing.
# 
# Example 1:
# 
#   Input: @nums = (1,2,2,4)
#   Output: (2,3)
# 
#   Duplicate is 2 and Missing is 3.
# 
# Example 2:
# 
#   Input: @nums =  1,2,3,4
#   Output: -1
# 
#   No duplicate and missing found.
# 
# Example 3:
# 
#   Input: @nums = (1,2,3,3)
#   Output: (3,4)
# 
#   Duplicate is 3 and Missing is 4.
# 
# MY NOTES: also pretty easy - especially if the list of integers should (if it
# were not for the one missing and one duplicated) form the sequence 1..N.
# if so: the duplicate is the element where el[i] != i.
# The missing is the sole member of set {1..N} - all el[i]
#
# Let's generalise it slightly to B, B+1, .. B+N-1.  Then: find the element
# where el[i] != el[0]+i, that is the duplicate, and the missing is the sole
# member of {B..N+N-1} - all el[i]
# 
# GUEST LANGUAGE: As a bonus, I also had a go at translating ch-2.pl into C
# (look in the C directory for that)
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Data::Dumper;

my $debug=0;
die "Usage: duplicate-and-missing [--debug] intlist\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV > 0;

my @list = split( /,/, join(',',@ARGV) );

say "list: ", join(',',@list) if $debug;

# check that it's sorted
my $prev = $list[0];
foreach my $i (1..$#list)
{
	die "dum: not sorted at element $list[$i]\n" if $list[$i] < $prev;
	$prev = $list[$i];
}

my $base = $list[0];
my $dup;

# find any duplicate, and die if there's only one duplicate
my %seen = ();
foreach my $i (0..$#list)
{
	my $expect = $base+$i;
	my $el = $list[$i];
	die "dum: bad input element $el\n" if $el > $expect;
	if( defined $seen{$el} )
	{
		die "dum: multiple duplicates found at element $el\n"
			if defined $dup;
		$dup = $el;
	}
	$seen{$el}++;
}

unless( defined $dup )
{
	say "-1";
	exit 0;
}

say "dup is $dup" if $debug;

# missing is sole member of {B..B+N-1} - all el[i]
my @all = map { $base+$_ } (0..$#list);
say "all expected are ", join(',',@all) if $debug;

my %all = map { $_ => 1 } @all;
foreach my $el (@list)
{
	delete $all{$el};
}
my $nmembers = keys %all;

die "dum: should be exactly 1 member in all now, not $nmembers\n"
	unless $nmembers == 1;
my( @missing ) = keys %all;

say "($dup, $missing[0])";
