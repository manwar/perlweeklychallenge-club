#!/usr/bin/perl
#
# Task 2: Max Number
# 
# You are given a list of positive integers.
# Write a script to concatenate the integers to form the highest possible value.
# 
# Example 1:
# 
#   Input: @list = (1, 23)
#   Output: 231
# 
# Example 2:
# 
#   Input: @list = (10, 3, 2)
#   Output: 3210
# 
# Example 3:
# 
#   Input: @list = (31, 2, 4, 10)
#   Output: 431210
# 
# Example 4:
# 
#   Input: @list = (5, 11, 4, 1, 2)
#   Output: 542111
# 
# Example 5:
# 
#   Input: @list = (1, 10)
#   Output: 110
# 
# MY NOTES: First thought: try all combinations.  Second thought: hang on,
# don't we always pick the number with the biggest initial digit, and if
# there's a tie, pick (from the numbers with the biggest initial digit) the
# one with the biggest prefix?  For example, if we vary example 4 to be:
# Input: @list = (5, 12, 4, 1, 2), the output would be 542121, ie. 5-4-2-12-1.
# Third thought: do I just mean "sort the numbers alphabetically"?
# Fourth thought: damn, not quite.  "1-10" beats "10-1". Blast. Can we
# specify a variant comparator that compares strings favouring shorter ones?
# Fifth thought: forget sorting.  Back to second thought:-)
# 
# GUEST LANGUAGE: As a bonus, I had a go at translating ch-2.pl into C,
# look in the C/ directory for that.
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Data::Dumper;
use List::Util qw(max);
use Function::Parameters;

my $debug=0;
die "Usage: max-concat-number [--debug] intlist\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV > 0;

my @list = split( /,/, join(',',@ARGV) );

say "debug: list: ", join(',',@list) if $debug;

#say join('', reverse sort { $a cmp $b } @list);


#
# my @l = delete_first( $v, @list );
#	Delete the first occurrence of $v from @list,
#	returning what's left.
#
fun delete_first( $v, @list )
{
	my $delete = 1;
	@list = grep { $_ != $v || ($delete-- <= 0) } @list;
	return @list;
}


#
# my $big = complex( $listref, @x );
#	Given @$listref, a list of numbers, and @x, a list of all the values
#	in @$listref that start with the biggest first digit, try playing
#	each of @x first, removing it from @$listref and finding the biggest
#	of what's left, then finding and returning the maximum of all those
#	possibilities.
#
fun complex( $listref, @x )
{
	# try each of these @x's plus all the rest, picking the biggest
	my $max = -1;
	foreach my $v (@x)
	{
		my $result = $v;
		my @newl = delete_first( $v, @$listref );
		say "debug: trying result $v, newl=". join(',',@newl)
			if $debug;
		$result .= find_biggest( @newl );
		say "debug: after trying $v + finding biggest, result=$result"
			if $debug;
		if( $result > $max )
		{
			$max = $result;
			say "debug: after trying $v, max=$max" if $debug;
		}
	}
	return $max;

}


#
# my $big = find_biggest( @list );
#	Given a list of numbers, try all concatenations
#	and find and return the biggest.
#
fun find_biggest( @list )
{
	my $result = "";

	while( @list )
	{
		# find max first digit
		my $maxdig = max( map { /^(.)/ && $1 } @list );
		my @x = grep { /^$maxdig/ } @list;
		say "debug: result=$result, list=". join(',',@list). ", maxdig=$maxdig, x=". join(',',@x)
			if $debug;

		if( @x == 1 )
		{
			$result .= $x[0];
			@list = delete_first( $x[0], @list );
			say "debug: 1 x: result=$result, new list=". join(',',@list). " after deleting $x[0]"
				if $debug;
		} else
		{
			say "debug: >1 x" if $debug;
			$result .= complex( \@list, @x );
			return $result;
		}
	}
	return $result;
}


my $big = find_biggest( @list );
say $big;
