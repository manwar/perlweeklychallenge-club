#!/usr/bin/perl
#
# Task 2: Rearrange Groups
# 
# You are given a list of integers and group size greater than zero.
# 
# Write a script to split the list into equal groups of the given size where
# integers are in sequential order. If it can't be done then print -1.
# 
# Example 1:
# 
#   Input: @list = (1,2,3,5,1,2,7,6,3) and $size = 3
#   Output: (1,2,3), (1,2,3), (5,6,7)
# 
# Example 2:
# 
#   Input: @list = (1,2,3) and $size = 2
#   Output: -1
# 
# Example 3:
# 
#   Input: @list = (1,2,4,3,5,3) and $size = 3
#   Output: (1,2,3), (3,4,5)
# 
# Example 4:
# 
#   Input: @list = (1,5,2,6,4,7) and $size = 3
#   Output: -1
# 
# MY NOTES: sounds reasonably easy as a brute force search.  But hang on, do we
# need backtracking or not?  i.e. if you find a run-of-$size-consecutive-numbers
# is that run necessarily a part of the solution, allowing you to extract any
# run you find (irrespective of what other runs may be present in the input)
# without needing to backtrack?  no, not if that run is PART of a longer run
# of consecutive numbers.  What if we only find run-of-$size-consecutive-
# numbers that are ISOLATED at the start, ie. where first(run)-1 is not
# present in the input?  Then we should be able to: repeatedly pick any one run,
# add it to solution, remove it from input, repeat until input is empty.
# 
# GUEST LANGUAGE: As a bonus, I will have a go at translating ch-2.pl into C
# but I'll do that tomorrow.
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Data::Dumper;
use Function::Parameters;

my $debug=0;
die "Usage: rearrange-groups [--debug] groupsize intlist\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV > 1;

my $size = shift;
my @list = split( /,/, join(',',@ARGV) );

say "debug: size=$size, list: ", join(',',@list) if $debug;


#
# my @seq = find_seq( $start, $size, %set );
#	Find a run-of-$size-consecutive-elements in %set starting
#	at $start, return the run iff we succeed in finding one,
#	() if none can be found.
#
fun find_seq( $start, $size, %set )
{
	return () if $set{$start-1};
	my @x;
	for( my $want=0; $want<$size; $want++ )
	{
		return () unless $set{$start+$want};
		push @x, $start+$want;
	}
	return @x;
}


#
# my @newlist = remove_one_of_seq( $seqref, @list );
#	Remove one of each member of @$seqref from @list, returning what's left.
#
fun remove_one_of_seq( $seqref, @list )
{
	my %set = map { $_ => 1 } @$seqref;

	for( my $i=@list-1; $i>=0; $i-- )
	{
		if( $set{$list[$i]} )
		{
			delete $set{$list[$i]};
			splice( @list, $i, 1 );
		}
	}
	return @list;
}


#
# my @run = find_isolated_seq( $size, @list );
#	Ok, find a single isolated run-of-$size-consecutive-numbers in @list,
#	and return the run (if one can be found), otherwise return ().
#
fun find_isolated_seq( $size, @list )
{
	my %set = map { $_ => 1 } @list;	# set of all distinct elements
	foreach my $start (sort { $a <=> $b } keys %set)
	{
		say "debug: looking for seq starting at $start" if $debug;
		my @seq = find_seq($start, $size, %set);
		next unless @seq;
		say( "debug: found seq ", join(',',@seq) ) if $debug;
		return @seq;
	}
	return ();
}



my @output;	# array of size-tuples

my $changed;
do
{
	my @seq = find_isolated_seq( $size, @list );
	say "debug: list=", join(',',@list), ", found seq=", join(',',@seq)
		if $debug;
	$changed = @seq ? 1 : 0;
	if( $changed )
	{
		push @output, \@seq;
		@list = remove_one_of_seq( \@seq, @list );
	}
	say( "debug: output: ", join(', ', map { '('. join(',',@$_). ')' } @output), ", list=",join(',',@list) )
		if $debug;

} while( $changed && @list );

say( "debug: leftover list is: ", join(',',@list) ) if $debug;

if( @list == 0 )
{
	say join(', ', map { '('. join(',',@$_). ')' } @output);
} else
{
	say -1;
}
