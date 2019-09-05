#!/usr/bin/perl
#
# Challenge 2: "Create a script that prints Prime Decomposition of a
# given number. The prime decomposition of a number is defined as a list
# of prime numbers which when all multiplied together, are equal to that
# number. For example, the Prime decomposition of 228 is 2,2,3,19 as 228 =
# 2 * 2 * 3 * 19."
# 
# My notes: So, prime factors then.  Very easy again.  In fact, haven't I
# already solved this in one of the other prime-based questions?
# 

use v5.10;	# for "say"
use strict;
use warnings;
use Function::Parameters;
#use Data::Dumper;

use lib qw(.);	# I hate this!
use MakePrimes;

die "Usage: ch-2.pl N\n" unless @ARGV == 1;
my $n = shift;

my @primes = primes_upto( $n );
my @factors = factorise( $n, @primes );
say "prime factors of $n are: ", join(',',@factors);


#
# my @factors = factorise( $n, @primes );
#	Break $n>1 apart into it's PRIME FACTORS (excluding 1),
#	using @primes as a list of all the prime numbers <= n
#	Return the list of prime factors, smallest first.
#	eg. factorise( 228 ) = 2,2,3,19
#
fun factorise( $n, @primes )
{
	die "factorise: n ($n) must be >1\n" if $n<=1;
	my @result;
	foreach my $p (@primes)
	{
		while( $n>1 && $n % $p == 0 )
		{
			push @result, $p;
			$n /= $p;
		}
		last if $n==1;
	}
	return @result;
}
