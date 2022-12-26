#!/usr/bin/perl
# 
# Task 1: Pattern 132
# 
# You are given a list of integers, @list.
# 
# Write a script to find out the first subsequence that respect Pattern 132.
# Return empty array if none found.
# 
# Pattern 132 in a sequence (a[i], a[j], a[k]) such that i < j < k
# and a[i] < a[k] < a[j].
# 
# Example 1
# 
# Input:  @list = (3, 1, 4, 2)
# Output: (1, 4, 2) respect the Pattern 132.
# 
# Example 2
# 
# Input: @list = (1, 2, 3, 4)
# Output: () since no subsequence can be found.
# 
# Example 3
# 
# Input: @list = (1, 3, 2, 4, 6, 5)
# Output: (1, 3, 2) if more than one subsequence found then return the first.
# 
# Example 4
# 
# Input: @list = (1, 3, 4, 2)
# Output: (1, 3, 2)
# 
# MY NOTES: very easy; straightforward "non-clever" code.
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
die "Usage: pattern-132 [--debug] intlist\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV>0;

=pod

=head2 my @sol = find_pat_132( @a );

Find and return the first subsequence of @a that matches the
132 rules above, or () if none.

=cut
sub find_pat_132
{
	my( @a ) = @_;
	for( my $i=0; $i<@a-2; $i++ )
	{
		for( my $j=$i+1; $j<@a-1; $j++ )
		{
			for( my $k=$j+1; $k<@a; $k++ )
			{
				return @a[$i,$j,$k] if
					$a[$i] < $a[$k] < $a[$j];
			}
		}
	}
	return ();
}


my @list = split( /,/, join(',',@ARGV) );

die "pattern-132: need at least 3 ints in list\n" unless @list>2;

my @sol = find_pat_132( @list );
say '( '. join( ', ', @sol ) . ' )';
