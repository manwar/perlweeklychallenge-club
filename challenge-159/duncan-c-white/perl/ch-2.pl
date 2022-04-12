#!/usr/bin/perl
# 
# TASK #2 - Moebius Number
# 
# You are given a positive number $n.
# 
# Write a script to generate the Moebius Number for the given number,
# definition: For any positive integer n, define moeb(n) as:
# 
#     moeb(n) = +1 if n is a square-free positive integer with an even
#     	         number of prime factors.
#     moeb(n) = 1 if n is a square-free positive integer with an odd
#     	         number of prime factors.
#     moeb(n) = 0 if n has a squared prime factor.
# 
# Example 1:
# 
# 	Input: $n = 5
# 	Output: -1
# 
# Example 2:
# 
# 	Input: $n = 10
# 	Output: 1
# 
# Example 3:
# 
# 	Input: $n = 20
# 	Output: 0
# 
# MY NOTES: ok.  Easy enough.  Reuse MakePrimes and PrimeFactors modules.
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Function::Parameters;
#use Data::Dumper;

use lib qw(.);
use MakePrimes;
use PrimeFactors;

my $debug=0;
my $tabulate=0;
die "Usage: moebius [--debug] [--tabulate] [N] (default 5)\n"
	unless GetOptions( "debug"=>\$debug, "tabulate"=>\$tabulate )
	    && @ARGV<2;

my $n = shift // 5;


#
# my $m = moeb( $n );
#	Return the Moebius number of $n, as described above.
#
fun moeb( $n )
{
	my @primes = primes_upto( $n );

	my @factors;
	@factors = prime_factors( $n, @primes ) if $n>1;
	@factors = () if $n==1;

	my %factorbag;
	$factorbag{$_}++ for @factors;

	say "moeb($n): prime factor bag: ",
		join(', ', map { "$_:$factorbag{$_}" } sort keys %factorbag )
		if $debug;

	foreach my $f (keys %factorbag)
	{
		if( $factorbag{$f}>1 )	# contains a square
		{
			say "moeb($n): contains a square: $f, so 0" if $debug;
			return 0;
		}
	}

	my $nfactors = @factors;
	print "moeb($n); has $nfactors factors: " if $debug;
	if( $nfactors % 2 == 0 )
	{
		say "even, so 1" if $debug;
		return 1;
	}
	say "odd, so -1" if $debug;
	return -1;
}

if( $tabulate )
{
	my @lines;
	my $line = '';
	foreach my $i (1..$n)
	{
		$line .= sprintf( "%2d: %2d", $i, moeb($i) );
		$line .= ', ';
		if( $i % 10 == 0 )
		{
			push @lines, $line;
			$line = '';
		}
	}
	say for @lines;
} else
{
	say moeb( $n );
}
