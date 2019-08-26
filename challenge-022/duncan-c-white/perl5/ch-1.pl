#!/usr/bin/perl
#
# Challenge 1: "Write a script to print first 10 Sexy Prime Pairs. Sexy
# primes are prime numbers that differ from each other by 6. For example,
# the numbers 5 and 11 are both sexy primes, because 11 - 5 = 6. The term
# "sexy prime" is a pun stemming from the Latin word for six: sex."
# 
# My notes: Clearly defined, yet another prime-based task, sounds very
# easy - let's have a go..  easy source of prime numbers is via my
# MakePrimes.pm module (itself converted from my earlier mkprimes.c)
# 

use strict;
use warnings;
use Function::Parameters;
#use Data::Dumper;

use lib qw(.);	# I hate this
use MakePrimes;

die "Usage: ch-1.pl [NUMSEXY]\n" if @ARGV>1;
my $wanted = shift // 10;

my $found = find_n_sexy_prime_pairs( $wanted );


#
# my $found = find_n_sexy_prime_pairs( $n );
#	Find $n sexy prime pairs.. return number of pairs found,
#	$found should always == $n
#
fun find_n_sexy_prime_pairs( $n )
{
	my %isprime;
	my $found = 0;

	my $w = 40000;
	my $from = $w;
	my @prime = primes_upto( $w );

	for(;;)
	{
		print "searching for sexy primes in ", scalar(@prime), " primes\n";
		foreach my $prime (@prime)
		{
			$isprime{$prime}++;
			if( $prime > 6 && $isprime{$prime-6} )
			{
				$found++;
				print "found sexy prime pair $found: ", $prime-6, " and $prime\n";
				if( $wanted == $found )
				{
					print "found $found sexy prime pairs\n";
					return $found;
				}
			}
		}
		print "found $found sexy prime pairs in pass, want $wanted\n";
		@prime = more_primes( $from, $from+$w );
		$from += $w;
	}
}
