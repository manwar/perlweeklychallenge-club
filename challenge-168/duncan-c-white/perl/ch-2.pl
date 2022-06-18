#!/usr/bin/perl
# 
# Task 2: Home Prime
# 
# You are given an integer greater than 1.
# 
# Write a script to find the home prime of the given number.
# 
# In number theory, the home prime HP(n) of an integer n greater than
# 1 is the prime number obtained by repeatedly factoring the increasing
# concatenation of prime factors including repetitions.
# 
# Further information can be found on Wikipedia
# 
# https://en.wikipedia.org/wiki/Home_prime
# 
# Example
# 
# As given in the Wikipedia page:
# 
# HP(10) = 773, as 10 factors as 2x5 yielding HP10(1) = 25, 25 factors
# as 5x5 yielding HP10(2) = HP25(1) = 55, 55 = 5x11 implies HP10(3)
# = HP25(2) = HP55(1) = 511, and 511 = 7x73 gives HP10(4) = HP25(3) =
# HP55(2) = HP511(1) = 773, a prime number.
# 
# MY NOTES: Ok, yet another prime variant.  I'll have a go, but I note that
# the numbers get enormous, to the point where it's not even known if HP(49)
# can be calculated.  Again can't use MakePrimes.pm, but can use a version
# of PrimeFactors hacked to test for primeness directly.
#

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
#use Data::Dumper;

use lib qw(.);
use PrimeFactors;

my $debug=0;
die "Usage: home-prime [--debug] [N default 10]\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV<2;
my $n = shift // 10;

my $x = $n;
do
{
	my @factors = prime_factors( $x );
	say "debug: prime factors of $x are ". join(',',@factors) if $debug;
	$x = join( '', @factors );
	say "debug: next x = $x" if $debug;
} while( ! isprime($x) );

say "hp($n) = $x";
