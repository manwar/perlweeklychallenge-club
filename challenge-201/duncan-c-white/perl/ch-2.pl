#!/usr/bin/perl
# 
# Task 2: Penny Piles
# 
# You are given an integer, $n > 0.
# 
# Write a script to determine the number of ways of putting $n pennies
# in a row of piles of ascending heights from left to right.
# 
# Example
# 
# Input: $n = 5
# Output: 7
# 
# Since $n=5, there are 7 ways of stacking 5 pennies in ascending piles:
# 
#     1 1 1 1 1
#     1 1 1 2
#     1 2 2
#     1 1 3
#     2 3
#     1 4
#     5
# 
# MY NOTES: not quite so easy, but doable.  Sounds recursive to me.
# Let's produce the array of answers too..
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
die "Usage: penny-piles [--debug] N\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV == 1;
my $n = shift;

die "penny-piles: N ($n) must be > 0\n" if $n<=0;


=pod

=head2 my @ways = penny( $n, $min, @prefix );

Calculate all the different ways of penny-allocating $n,
according to the rules at the top.  Return a list of all
the ways, a list of lists, prepending @prefix to every
way found.

=cut
fun penny( $n, $min, @prefix )
{
	return () if $n<$min;
	return ( [@prefix,$min] ) if $n==$min;
	my @ways;
	for( my $i=$min; $i<$n; $i++ )
	{
		if( $n-$i >= $min )
		{
			push @ways, penny( $n-$i, $i, @prefix, $i );
		}
	}
	if( $n >= $min )
	{
		push @ways, [ @prefix, $n ];
	}
	return @ways;
}


my @ways = penny( $n, 1, () );
my $nways = @ways;

say $nways;

say "ways:";
say join( ',', @$_ ) foreach @ways;
