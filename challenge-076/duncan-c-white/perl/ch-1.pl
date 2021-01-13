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
# My notes: ok. pretty straightforward.  One question: do the primes have to be
# different, it doesn't say "minimum number of DIFFERENT prime numbers.." so I
# assume they can be the same..
#

use strict;
use warnings;
use feature 'say';
use Function::Parameters;
use Data::Dumper;

use lib qw(.);
use MakePrimes;

die "Usage: prime-sum target\n" unless @ARGV==1;
my $N = shift;

my @primes = primes_upto( $N );	# definitely enough

my %isprime = map { $_ => 1 } @primes;

if( $isprime{$N} )
{
	say "$N is a prime: so sum of 1-prime ($N itself) is $N";
	exit 0;
}


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


foreach my $nprimes (2..$N)
{
	say "looking for an $nprimes-primes sum that is $N";
	my @soln = findsum( $nprimes, $N );
	if( @soln )
	{
		say "found sum of $nprimes primes == $N, primes are: ", join(',',@soln);
		last;
	}
}

