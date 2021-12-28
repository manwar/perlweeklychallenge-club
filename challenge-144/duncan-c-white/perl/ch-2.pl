#!/usr/bin/perl
# 
# TASK #2 - Ulam Sequence
# 
# You are given two positive numbers, $u and $v.
# 
# Write a script to generate Ulam Sequence having at least 10 Ulam numbers
# where $u and $v are the first 2 Ulam numbers.
# 
# For more information about Ulam Sequence, please checkout the website
# https://en.wikipedia.org/wiki/Ulam_number
# 
# The standard Ulam sequence (the (1, 2)-Ulam sequence) starts with U1 =
# 1 and U2 = 2. Then for n > 2, Un is defined to be the smallest integer
# that is the sum of two distinct earlier terms in exactly one way and
# larger than all earlier terms.
# 
# Example 1
# 
# 	Input: $u = 1, $v = 2
# 	Output: 1, 2, 3, 4, 6, 8, 11, 13, 16, 18
# 
# Example 2
# 
# 	Input: $u = 2, $v = 3
# 	Output: 2, 3, 5, 7, 8, 9, 13, 14, 18, 19
# 
# Example 3
# 
# 	Input: $u = 2, $v = 5
# 	Output: 2, 5, 7, 9, 11, 12, 13, 15, 19, 23
# 
# 
# MY NOTES: hmm..  sounds relatively straightforward.  I'm slightly puzzled
# by "in exactly one way", but an article linked from the Wikipedia page
# gives the clearer definition:
#
# Un+1 is the smallest integer > Un that can be written Uj+Uk for exactly
# one pair (j,k) where 1<=j<k<=n.
#
# The "exactly one pair" suggests to me a frequency hash of pair-sums.
# So I propose:
# - we check each distinct pair of earlier terms Uj, Uk,
# - building a frequency hash of all $freq{Uj+Uk > Un} we find.
# Then pick all keys of %freq whose frequency is 1.
# Then pick the smallest.
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Data::Dumper;
use Function::Parameters;


my $debug=0;


#
# my $next = next_ulam( @terms );
#	Given @terms, an array of Ulam terms found so far,
#	find and return the next Ulam term.
#	Remember: Un+1 is the smallest integer > Un that can be written
#	  Uj+Uk for exactly one pair (j,k) where 1<=j<k<=n.
#
#	The "exactly one pair" suggests to me a frequency hash.
#	So I propose:
#	- we check each distinct pair of earlier terms Uj, Uk,
#	- building a frequency hash of all $freq{Uj+Uk > Un} we find.
#	Then pick all keys of %freq whose frequency is 1.
#	Then pick the smallest.
#
fun next_ulam( @terms )
{
	my $min = 1+$terms[-1];		# next term must be >= $min

	my %freq;			# frequency hash of all pairsums

	# foreach distinct pair of terms ($t1,$t2)..
	for( my $i=0; $i<@terms-1; $i++ )
	{
		my $t1 = $terms[$i];
		for( my $j=$i+1; $j<@terms; $j++ )
		{
			my $t2 = $terms[$j];
			my $sum = $t1 + $t2;

			$freq{$sum}++ if $sum >= $min;
		}
	}
	say "debug: ", Dumper \%freq if $debug;

	# select values with frequency 1
	my @f1 = grep { $freq{$_}==1 } keys %freq;

	# sort values numerically
	@f1 = sort { $a <=> $b } @f1;
	
	# return first (smallest) of the sorted values
	return $f1[0];
}


#
# my @ulam = ulam_seq( $u, $v, $n );
#	Find the Ulam sequence with $n terms, of which the first two
#	are $u and $v.  See the main definition at the top of this file
#	for full definitions of Ulam sequences.
#
fun ulam_seq( $u, $v, $n )
{
	my @us = ( $u, $v );		# ulam sequence so far;
	for( my $i=3; $i<=$n; $i++ )
	{
		# find the next ulam sequence term
		my $nextterm = next_ulam( @us );
		push @us, $nextterm;
	}
	return @us;
}


die "Usage: ulam-sequence [--debug] U V [NTerms default 10]\n" unless
	GetOptions( "debug"=>\$debug ) && (@ARGV==2 || @ARGV==3);
my $u = shift;
my $v = shift;
my $n = shift // 10;

my @ulam = ulam_seq( $u, $v, $n );
say join(', ', @ulam );
