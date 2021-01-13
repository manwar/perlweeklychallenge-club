#!/usr/bin/perl
#
# Task #2: "Noble Integer
#
# You are given a list, @L, of three or more random integers between 1 and
# 50. A Noble Integer is an integer N in @L, such that there are exactly
# N integers greater than N in @L. Output any Noble Integer found in @L,
# or an empty list if none were found.
# 
# An interesting question is whether or not there can be multiple Noble
# Integers in a list.
# 
# For example,
# 
# Suppose we have list of 4 integers [2, 6, 1, 3].
# 
# Here we have 2 in the above list, known as Noble Integer, since there
# are exactly 2 integers in the list greater than 2: 3 and 6.
# 
# Therefore the script would print 2.
# "
# 
# My notes: Interesting, especially the question about "whether or not there
# can be multiple Noble Integers in a list": If repeated numbers are allowed,
# you can definitely have multiple (identical) noble numbers eg 2 1 1 1 1...
# (each 1 is noble because there's exactly one number >1 (the 2)).
# So disallow that.
# Now, given distinct numbers, I don't think multiple noble numbers are possible
# in one list. "find a list with 2 numbers greater than 2 and 3 numbers greater
# than 3" is not possible, because every number greater than 3 is ALSO greater
# than 2, so there are at least as many numbers greater than 2 as there are
# numbers greater than 3, i.e. at least 3 numbers in the list are greater than 2,
# which contradicts the specification that only (exactly) 2 numbers in the list are
# greater than 2.
# 

use strict;
use warnings;
use feature 'say';
use Function::Parameters;
#use Data::Dumper;

die "Usage: noble list_of_3_or_more_ints\n" unless @ARGV>2;

foreach my $i (@ARGV)
{
	die "noble: element $i out of range 1..50\n" unless
		$i >= 1 && $i <= 50;
}

# remove duplicate items by turning list into set..
my %set = map { $_ => 1 } @ARGV;

# and finding the (distinct) keys of that set..
my @l = keys %set;

my @noble = find_all_noble( @l );
say "noble: $_" for @noble;


#
# my @noble = find_all_noble( @l );
#	Find and return a list of all noble elements in @l,
#	or the empty list if none are noble.  The definition
#	of noble is from above:
#	"A Noble Integer is an integer N in @L,
#	such that there are exactly N integers greater than N in @L"
#
fun find_all_noble( @l )
{
	my @noble;
	foreach my $element (@l)
	{
		my $ngt = grep { $_ > $element } @l;
		push @noble, $element if $element == $ngt;
	}
	return @noble;
}
