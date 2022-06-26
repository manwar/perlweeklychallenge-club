#!/usr/bin/perl
# 
# TASK 1: Primorial Numbers
# 
# Write a script to generate first 10 Primorial Numbers:
# Primorial numbers are those formed by multiplying successive prime numbers.
# 
# For example,
# 
# P(0) = 1    (1)
# P(1) = 2    (1x2)
# P(2) = 6    (1x2x3)
# P(3) = 30   (1x2x3x5)
# 
# MY NOTES: ok, sounds easy, but I'm getting very bored of
# "tasks to do with Number Theory and (especially) Primes".
# Let's reuse the MakePrimes module.
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
#use Data::Dumper;

use lib qw(.);
use MakePrimes;

my $debug=0;
die "Usage: primorials [--debug] [N default 10]\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV<2;
my $n = shift // 10;

# get first $n or more primes
my $lim = 4 * $n;
my @primes = primes_upto( $lim );
while( @primes < $n )
{
	push @primes, more_primes( $lim, $lim*2 );
	$lim *= 2;
}

#die join(', ', @primes );

# now calculate the primorials
my $p = 1;			# current primorial
my @primorial = ($p);
while( @primorial < $n )
{
	die "ran out of primes, p=$p\n" unless @primes;
	my $nextprime = shift @primes;
	$p *= $nextprime;
	push @primorial, $p;
}

say join(', ', @primorial );
