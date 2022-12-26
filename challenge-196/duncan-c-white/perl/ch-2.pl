#!/usr/bin/perl
# 
# Task 2: Range List
# 
# You are given a sorted unique integer array, @array.
# 
# Write a script to find all possible Number Range i.e [x, y] represent
# range all integers from x and y (both inclusive).  Each subsequence
# must be of two or more contiguous integers.
# 
# Example 1
# 
# Input: @array = (1,3,4,5,7)
# Output: [3,5]
# 
# Example 2
# 
# Input: @array = (1,2,3,6,7,9)
# Output: [1,3], [6,7]
# 
# Example 3
# 
# Input: @array = (0,1,2,4,5,6,8,9)
# Output: [0,2], [4,6], [8,9]
# 
# MY NOTES: simple enough state machine while we walk over the array in 1-pass.
# 
# GUEST LANGUAGE: As a bonus, I also had a go at translating ch-2.pl
# into C (look in the C directory for the translation)
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Function::Parameters;
use Data::Dumper;


my $debug=0;
die "Usage: range-list [--debug] list(int)\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV>0;

=pod

=head2 my @range = find_ranges( @list );

Find and return all ranges of consecutive numbers in @list.
Each range is an [from,to] pair.

=cut
fun find_ranges( @list )
{
	my @result;
	my $from = -1;
	my $to = -1;
	foreach my $item (@list)
	{
		if( $from == -1 )		# start first range
		{
			$from = $item;
			$to = $item;
			say "debug: item=$item, 1st range $from..$to" if $debug;
		} elsif( $item == $to+1 )	# extend current range
		{
			$to++;
			say "debug: item=$item, extend range $from..$to" 
				if $debug;
		} else				# finish one range, start next
		{
			if( $to > $from )	# len > 1: add range
			{
				push @result, [$from,$to];
				say "debug: item=$item, add range $from..$to"
					if $debug;
			}
			$from = $item;
			$to = $item;
			say "debug: item=$item, new range $from..$to" if $debug;
		}
	}
	if( $to > $from )			# len > 1: add range
	{
		push @result, [$from,$to];
		say "debug: add final range $from..$to" if $debug;
	}
	return @result;
}




my @list = split( /,/, join( ',', @ARGV ) );

die "range-list: need at least 3 ints in list\n" unless @list>2;

my @range = find_ranges( @list );
#die Dumper( \@range );
say join( ', ', map { "[$_->[0],$_->[1]]" } @range );
