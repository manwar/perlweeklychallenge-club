#!/usr/bin/perl
# 
# TASK #2 - Stealthy Number
# 
# You are given a positive number, $n.
# 
# Write a script to find out if the given number is Stealthy Number.
# 
# A positive integer N is stealthy, if there exist positive integers
# a, b, c, d such that a * b = c * d = N and a + b = c + d + 1.
# 
# Example 1
# 
# 	Input: $n = 36
# 	Output: 1
# 
# 	Since 36 = 4 (a) * 9 (b) = 6 (c) * 6 (d) and
# 	4 (a) + 9 (b) = 6 (c) + 6 (d) + 1.
# 
# Example 2
# 
# 	Input: $n = 12
# 	Output: 1
# 
# 	Since 2 * 6 = 3 * 4 and 2 + 6 = 3 + 4 + 1
# 
# Example 3
# 
# 	Input: $n = 6
# 	Output: 0
# 
# 	Since 2 * 3 = 1 * 6 but 2 + 3 != 1 + 6 + 1
# 
# 
# MY NOTES: hmm..  need some kind of brute force search, presumably.
# what are the limits of a..d?  first thought: each <= $n,
# hang on, (a,b) must be a factor pair of n (where a is a factor of n
# <= sqrt(n) and b is n/a), and (c,d) must also be a factor pair of n.
#
# As a bonus, I've also implemented the --firstn flag which makes it
# find and display the first $n stealthy numbers.
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Data::Dumper;

#
# my @fact = factorpairs( $n );
#	Find and return all the factor pairs ($x,$y) of $n
#	where $x is a factor of $n from 1..sqrt(n), and
#	$y is $n/$x
#
sub factorpairs
{
	my( $n ) = @_;
	my @f = ( [1,$n] );
	my $sqrtn = int(sqrt($n));
	for( my $i=2; $i<=$sqrtn; $i++ )
	{
		push @f, [ $i, $n/$i ] if $n%$i==0;
	}
	return @f;
}


#
# my( $isstealthy, $a, $b, $c, $d ) = stealthy( $n );
#	Determine whether or not $n is stealthy.  If not, return (0).
#	If it is, return (1, a, b, c, d) where a, b, c and d are one
#	possible stealthy set of numbers.
#
sub stealthy
{
	my( $n ) = @_;

	my @fp = factorpairs( $n );
	#say Dumper \@fp;

	foreach my $ab (@fp)
	{
		my( $a, $b ) = @$ab;
		foreach my $cd (@fp)
		{
			my( $c, $d ) = @$cd;
			# check whether a + b = c + d + 1.
			return (1, $a, $b, $c, $d) if
				$a + $b == $c + $d + 1;
		}
	}

	return (0);
}


my $debug=0;
my $firstn = 0;
die "Usage: steathy-number [--debug] [--firstn] N\n" unless
	GetOptions( "debug"=>\$debug, "firstn"=>\$firstn ) && @ARGV==1;
my( $n ) = @ARGV;

if( $firstn )
{
	my $found=0;
	for( my $i=0; $found<$n; $i++ )
	{
		my( $isstealthy, $a, $b, $c, $d ) = stealthy( $i );
		if( $isstealthy )
		{
			say "$i: stealthy: $a, $b, $c, $d";
			$found++;
		}
	}
} else
{
	my( $isstealthy, $a, $b, $c, $d ) = stealthy( $n );
	if( $isstealthy )
	{
		say "1: $a, $b, $c, $d";
	} else
	{
		say "0";
	}
}
