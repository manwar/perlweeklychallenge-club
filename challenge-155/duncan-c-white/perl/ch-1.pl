#!/usr/bin/perl
# 
# TASK #1 - Fortunate Numbers
# 
# Write a script to produce first 8 Fortunate Numbers (unique and sorted).
# 
# A Fortunate number, named after Reo Fortune, is the smallest integer m >
# 1 such that, for a given positive integer n, pn# + m is a prime number,
# where the primorial pn# is the product of the first n prime numbers.
# 
# Expected Output
# 
# 3, 5, 7, 13, 17, 19, 23, 37
# 
# MY NOTES: ok.  Note that the Wikipedia article is not clear whether the
# Nth Fortunate number is the smallest integer m>1 s.t. pN# + m is prime,
# or whether that Nth value found is **A* Fortunate number, but the Fortunate
# numbers themselves are sorted and have duplicates removed - and the Nth
# Fortunate number is the Nth term of the sorted and deduped list.  I think
# we want the latter, because the unsorted Fortunate numbers corresponding to
# pn# for n=1..8 are 3, 5, 7, 13, 23, 17, 19, 23, i.e. they are not sorted and
# contain a duplicate of 23.
# 
# Once you sort and dedup these, you get the desired sequence
# 3, 5, 7, 13, 17, 19, 23, 37
# 
# HOWEVER, it's not obvious how many unsorted Fortunate numbers we have
# to calculate to know that we've found the first N sorted ones.  Let's keep
# going until we have found N distinct Fortunate numbers and then sort them.
# Is it possible for a later unsorted Fortunate number to be smaller
# than one of the ones we've # found so far?  Yes, blast it:
# The output of this program for N=1 is 3,5,7,13,17,19,23,37,61,67,71
# and for N=12 is 3,5,7,13,17,19,23,37,47,61,67,71
# (showing that the 12th distinct value found is 47, smaller than the 9th..11th
# distinct value found)
#
# Also, this program won't work for N>12 because the primorial values get so
# enormous, like factorials.  I tried bigint but that slowed everything down
# so much that I couldn't find the answers in the time I had available.
# 

use strict;
use warnings;
use feature 'say';
#use bigint;
use Function::Parameters;
use Getopt::Long;
#use Data::Dumper;

my $debug=0;
die "Usage: first-n-fortunates [--debug] [N default 8]\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV<2;
my $n = shift // 8;


my %tested;		# values we've already tested for primeness
my %isprime;		# values we've tested and found to be prime


#
# my $isprime = isprime( $x );
#	Return 1 iff $x is prime.  Memoize the ones we know.
#
fun isprime( $x )
{
	return $isprime{$x} if $tested{$x};

	$tested{$x}++;
	$isprime{$x} = 0;
	my $lim = int(sqrt($x));
	for( my $i=2; $i<=$lim; $i++ )
	{
		return 0 if $x % $i == 0;
	}
	$isprime{$x} = 1;
	return 1;
}


#
# my $f = smallest_prime_above( $x );
#	Find and return the first prime number above $x+1
#	Couldn't use my MakePrimes module for this, as $x
#	tends to be huge (as it's typically called with a primorial)
#	and we test a small dense sequence of numbers
#	from x+2..x+m for primeness.  there's no point computing
#	all primes in the whole range 1...x+m
#
fun smallest_prime_above( $x )
{
	my $m;
	for( $m = 2; ! isprime($x+$m); $m++ )
	{
	}
	return $m;
}


#
# my $nextprime = next_prime($prime);
#	Given $prime, a prime number, find and return the next prime number.
#
fun next_prime( $p )
{
	for( $p++; !isprime($p); $p++ )
	{
	}
	return $p;
}


my $primorial = 1;

my %fortunate;
my $nf=0;

my $prime = 2;

while( $nf < $n )
{
	$primorial *= $prime;	# primorial of the first few primes
	my $f = smallest_prime_above( $primorial );
	say "debug: prime $prime, primorial $primorial, fortunate no $f, nbefore $nf" if $debug;
	$nf++ unless $fortunate{$f}++;
	$prime = next_prime($prime);
}

say join( ',', sort { $a <=> $b } keys %fortunate );
