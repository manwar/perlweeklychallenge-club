#!/usr/bin/perl

# Challenge 1: "The numbers formed by adding one to the products of the
#   smallest primes are called the Euclid Numbers. Write a script that finds
#   the smallest Euclid Number that is not prime."
#
#   My notes:
#
#   From the wiki:
#
#   primes are 2, 3, 5, 7, 11, 13..
#   products are 2, 6, 30, 210, 2310, 30030...
#   and Euclid numbers are 3, 7, 31, 211, 2301, 30031...
#
#   btw, the Wiki page gives the answer:
# 	  E(6)=30031 is first composite Euclid number (59x509)
# 
#   Euclid numbers will grow like factorials, being products, will we need
#   to use bigint?  30031 being the answer suggests not:-).  Have a "mkprimes.c"
#   program to generate primes up to N, so let's try using primes as data rather
#   than generating them ourselves.  Just need isprime(n) function checking
#   i=2..sqrt(n).  Simple!
#
#   As a bonus, let's factorise the first non-prime Euclid number

use strict;
use warnings;
use Function::Parameters;
use Data::Dumper;

# array of first few primes (nb: 1 is not a prime)
my @prime = (
	2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 
	#31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 
	#73, 79, 83, 89, 97, 
);
my %isprime = map { $_ => 1 } @prime;

# my $factor = findonefactor( $n );
#	return any single factor of $n, or 1 if $n is prime.
fun findonefactor( $n )
{
    die "findonefactor: bad input $n (< 2)\n" if $n < 2;
    return 1 if $isprime{$n};
    for ( 2 .. int sqrt($n) )
    {
        return $_ if $n % $_ == 0;
    }
    return 1;
}


#
# my @f = factorise( $n, $factor );
#	Completely factorise n, given one factor $factor
#	(which "my $factor = findonefactor( $n );" would deliver)
#
fun factorise( $n, $factor )
{
	my @f;
	do {
		push @f, $factor;
		$n /= $factor;
		$factor = findonefactor( $n );
	} while( $factor > 1 );
	push @f, $n unless $n==1;
	return @f;
}


my $primeprod=1;
foreach my $prime (@prime)
{
	$primeprod *= $prime;
	#print "prime=$prime, prod=$primeprod\n";
	my $euclidno = $primeprod+1;
	my $factor = findonefactor( $euclidno );
	my $isnot = $factor==1 ? "is" : "is not";
	print "prime=$prime, prod=$primeprod, euclid=$euclidno: $isnot prime\n";
	next if $factor == 1;
	my @f = factorise( $euclidno, $factor );
	print "factors of $euclidno are: ", join(',',@f), "\n";
	exit 0;
}
