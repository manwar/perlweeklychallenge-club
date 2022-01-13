#!/usr/bin/perl
# 
# TASK #2 - Palindromic Tree
# 
# You are given a string $s.
# 
# Write a script to create a Palindromic Tree for the given string.
# 
# I found this blog exaplaining Palindromic Tree in detail:
# 
# https://medium.com/@alessiopiergiacomi/eertree-or-palindromic-tree-82453e75025b
# 
# Example 1:
# 
# 	Input: $s = 'redivider'
# 	Output: r redivider e edivide d divid i ivi v
# 
# Example 2:
# 
# 	Input: $s = 'deific'
# 	Output: d e i ifi f c
# 
# Example 3:
# 
# 	Input: $s = 'rotors'
# 	Output: r rotor o oto t s
# 
# Example 4:
# 
# 	Input: $s = 'challenge'
# 	Output: c h a l ll e n g
# 
# Example 5:
# 
# 	Input: $s = 'champion'
# 	Output: c h a m p i o n
# 
# Example 6:
# 
# 	Input: $s = 'christmas'
# 	Output: c h r i s t m a
# 
# MY NOTES: hmm..  I read the blog, but what on earth is
# it talking about?  the underlying paper https://arxiv.org/pdf/1506.04862.pdf
# is a lot clearer, but way too detailed for 10pm on a Sunday.
#
# looking at the examples given above, the output seems to be
# a list of palindromic substrings not previously encountered,
# in the natural order found by sequencing through every starting
# position in the word and trying increasingly long substrings
# for "Palindromic"-ness.
# 
# So, could we solve the "generate the output from the input"
# problem, entirely ignoring the whole "build a weird tree"
# part of it?  Presumably a lot less efficient than their
# clever eertree/Palindrome tree thingy, but who cares.
#
# So let's give that a try.
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Data::Dumper;
use Function::Parameters;


my $debug=0;

#
# my @pals = palindomes( $s );
#	Generate and return the list of all subpalindromes of $s
#	in the desired order.
#
fun palindomes( $s )
{
	my @result;
	my %seen;
	my $len = length($s);

	for( my $i=0; $i < $len; $i++ )
	{
		my $ch = substr($s,$i,1);
		push @result, $ch unless $seen{$ch}++;
		for( my $j=$i+1; $j < $len; $j++ )
		{
			my $substr = substr($s,$i,1+$j-$i);
			next unless reverse($substr) eq $substr;
			say "debug: i=$i, j=$j, substr=$substr" if $debug;
			push @result, $substr unless $seen{$substr}++;
		}
	}
	return @result;
}



die "Usage: palindrome-trees [--debug] string\n" unless
	GetOptions( "debug"=>\$debug ) && @ARGV==1;
my $s = shift;

my @pals = palindomes( $s );

say join( ' ', @pals );
