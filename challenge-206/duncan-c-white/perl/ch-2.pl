#!/usr/bin/perl
#
# Task 2: Array Pairings
# 
# You are given an array of integers having even number of elements..
# Write a script to find the maximum sum of the minimum of each pairs.
# 
# Example 1
# 
#   Input: @array = (1,2,3,4)
#   Output: 4
# 
#   Possible Pairings are as below:
#   a) (1,2) and (3,4). So min(1,2) + min(3,4) => 1 + 3 => 4
#   b) (1,3) and (2,4). So min(1,3) + min(2,4) => 1 + 2 => 3
#   c) (1,4) and (2,3). So min(1,4) + min(2,3) => 2 + 1 => 3
# 
#   So the maxium sum is 4.
# 
# Example 2
# 
#   Input: @array = (0,2,1,3)
#   Output: 2
# 
#   Possible Pairings are as below:
#   a) (0,2) and (1,3). So min(0,2) + min(1,3) => 0 + 1 => 1
#   b) (0,1) and (2,3). So min(0,1) + min(2,3) => 0 + 2 => 2
#   c) (0,3) and (2,1). So min(0,3) + min(2,1) => 0 + 1 => 1
#   
#   So the maximum sum is 2.
# 
# MY NOTES: hmm. I wish one of the examples had 6 elements.  It seems
# to me that this sounds like a recursive solution..  Pick each possible
# pair involving the first element and each of the others (in turn),
# remove them, calculate and total up the minimum, then recurse.
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Function::Parameters;
use Data::Dumper;
use List::Util qw(min max);

my $debug=0;
die "Usage: array-pairings [--debug] even-len-intlist\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV > 0;

my @list = split( /,/, join(',',@ARGV) );
my $nel = @list;

die "array-pairings: need even number of integers, not $nel\n" if $nel % 2 == 1;

say "list: ", join(',',@list) if $debug;

=pod

=head2 find_all( $sum, $solarrayref, @list );

Given an even-length list @list, a sum so far ($sum),
and a reference to an array of solutions ($solarrayref),
pick all possible pairs of items from @list including
the first item in the list, and min(that pair) to the sum,
and recurse on the rest of the array.  Accumulate all
solutions (final value of $sum when @list is empty) in @$solarrayref.

=cut
fun find_all( $sum, $solarrayref, @list )
{
	if( @list == 0 )
	{
		push @$solarrayref, $sum;
		return;
	}

	# find all pairs of first item, another item in @list
	my $first = shift @list;
	foreach my $spos (0..$#list)
	{
		my $second = $list[$spos];
		my $min = min($first,$second);
		my @newl = ( @list[0..$spos-1], @list[$spos+1..$#list] );
		say "debug: removed $first and $second (min $min), leaving ",
			join(',',@newl) if $debug;
		find_all( $sum+$min, $solarrayref, @newl );
	}
}


my @solutions;	# list of all solutions, final answer is max(these)

find_all( 0, \@solutions, @list );

say "pairing solutions: ", join(',',@solutions) if $debug;

my $max = max(@solutions);
say $max;
