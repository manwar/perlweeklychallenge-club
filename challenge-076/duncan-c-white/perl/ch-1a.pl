#!/usr/bin/perl
#
# Task 1: "Prime Sum
#
# You are given a number $N. Write a script to find the minimum number of
# prime numbers required, whose summation gives you $N.
# For the sake of this task, 1 is not a prime number.
# 
# Example:
# 
# Input:
#     $N = 9
# 
# Ouput:
#     2 as sum of 2 prime numbers i.e. 2 and 7 is same as the input number.
#     2 + 7 = 9.
# "
# 
# My notes: VARIATION: let's find out the smallest number $N that CANNOT be represented
# as a sum of 2 prime numbers..
#

use strict;
use warnings;
use feature 'say';
use Function::Parameters;
use Data::Dumper;

use lib qw(.);
use MakePrimes;

die "Usage: smallestn-not-sum-2-primes\n" unless @ARGV==0;

my @primes = primes_upto( 100 );
my %isprime = map { $_ => 1 } @primes;


#
# my @soln = findsum( $nprimes, $N );
#	Try to find a list of exactly $nprimes primes (held in global @primes)
#	that sums to $N.  If we find such a list of primes, return that list.
#	If we find no such list of primes, return ().
#
fun findsum( $nprimes, $N )
{
	if( $nprimes == 1 )
	{
		return $isprime{$N} ? ($N) : ();
	}
	# $nprimes>1
	foreach my $p (@primes)
	{
		last if $p >= $N;

		# $p < $N
		my @soln = findsum( $nprimes-1, $N-$p );
		if( @soln )
		{
			unshift @soln, $p;
			return @soln;
		}

	}
	return ();
}


foreach my $N (2..100)
{
	my @soln = findsum( 2, $N );
	if( @soln )
	{
		#say "found sum of 2 primes == $N, primes are: ", join(',',@soln);
	} else
	{
		say "DIDN'T find sum of 2 primes == $N";
	}
}

