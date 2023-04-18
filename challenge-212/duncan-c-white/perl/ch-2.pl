#!/usr/bin/perl
#
# Task 2: Rearrange Groups (into sequences)
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



#
# my $done = find_all_sequences( \@list, $size, \@output );
#	Attempt to extract all sequences (each of length $size and
#	comprising X, X+1, X+2..X+size-1) from @list, modifying it,
#	and building @output - a list of size-tuples.  Return true
#	if it can be successfully done (leaving @list empty and the
#	sequences in @output), false if it can't be done.
#
sub find_all_sequences ($$$)
{
	my( $listref, $size, $outputref ) = @_;

	if( @$listref % $size != 0 )
	{
		return 0;
	}

	my $nseqs = @$listref / $size;

	foreach my $seqno (1..$nseqs)
	{
		my @seq = find_isolated_seq( $size, @$listref );
		say "debug: list=", join(',',@$listref), ", found seq=",
		    join(',',@seq)
			if $debug;
		if( @seq == 0 )
		{
			say( "debug: failed to find a sequence, leftover list".
			     " is: ", join(',',@$listref) ) if $debug;
			return 0;
		}
		push @$outputref, \@seq;
		@$listref = remove_one_of_seq( \@seq, @$listref );
		say( "debug: output: ", join(', ',
		     map { '('. join(',',@$_). ')' } @$outputref
		     ), ", list=",join(',',@$listref) )
			if $debug;
	}
	return 1;
}


my @output;	# array of size-tuples

my $done = find_all_sequences( \@list, $size, \@output );

if( $done )
{
	say join(', ', map { '('. join(',',@$_). ')' } @output);
} else
{
	say -1;
}
