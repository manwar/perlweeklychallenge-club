#!/usr/bin/perl
#
# Task 2: "Count Candies
#
# You are given rankings of @N candidates.
# 
# Write a script to find out the total candies needed for all candidates. You are asked to follow the rules below:
# a) You must given at least one candy to each candidate.
# b) Candidate with higher ranking get more candies than their mmediate neighbors on either side.
# Example 1:
# 
# Input: @N = (1, 2, 2)
# 
# Explanation:
# 
# Applying rule #a, each candidate will get one candy. So total candies
# needed so far 3. Now applying rule #b, the first candidate do not get any
# more candy as its rank is lower than it's neighbours. The second candidate
# gets one more candy as it's ranking is higher than it's neighbour. Finally
# the third candidate do not get any extra candy as it's ranking is not
# higher than neighbour. Therefore total candies required is 4.
# 
# Output: 4
# 
# Example 2:
# 
# Input: @N = (1, 4, 3, 2)
# 
# Explanation:
# 
# Applying rule #a, each candidate will get one candy. So total candies
# needed so far 4. Now applying rule #b, the first candidate do not get
# any more candy as its rank is lower than it's neighbours. The second
# candidate gets two more candies as it's ranking is higher than it's
# both neighbour. The third candidate gets one more candy as it's ranking
# is higher than it's neighbour. Finally the fourth candidate do not get
# any extra candy as it's ranking is not higher than neighbour. Therefore
# total candies required is 7.
# 
# Output: 7
# "
# 
# My notes: those rules could have written more clearly, but the examples
# clarify that the "neighbours" are linear, not in a ring, so the two
# end people's rankings each have only one neighbour to check.  Each person
# gets between 1..3 candies.  Pretty simple.
#

use strict;
use warnings;
use feature 'say';
use Function::Parameters;
use Data::Dumper;
use List::Util qw(max);

die "Usage: count-candies list_of_ints\n" unless @ARGV>=1;
my @r = @ARGV;

#
# my $candies = count_candies( @r );
#	Count the number of candies to be given to people with
#	rankings @r; return the number of candies.
#
fun count_candies( @r )
{
	my $candies=@r;
	foreach my $pos (0..$#r)
	{
		$candies++ if $pos>0 && $r[$pos-1] < $r[$pos];
		$candies++ if $pos<$#r && $r[$pos+1] < $r[$pos];
	}
	return $candies;
}


#
# my $candies = count_candies2( @r );
#	BETTER WAY to count the number of candies to be given to people with
#	rankings @r; it occurred to me that an extra candy is given whenever
#	each adjacent pair of rankings are different (if the first is bigger,
#	the extra candy is given to the first person, otherwise to the second).
#	only if the two adjacent rankings are the SAME is no extra candy given.
#
fun count_candies2( @r )
{
	my $candies=@r;
	foreach my $pos (0..$#r-1)
	{
		$candies++ if $r[$pos] != $r[$pos+1];
	}
	return $candies;
}


my $candies = count_candies( @r );
my $candies2 = count_candies2( @r );
die "candies:$candies, candies2:$candies2\n" unless $candies==$candies2;
say $candies;
