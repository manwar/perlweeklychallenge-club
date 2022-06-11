#!/usr/bin/perl
# 
# TASK #2 - Padovan Prime
# 
# A Padovan Prime is a Padovan Number that's also prime.
# 
# In number theory, the Padovan sequence is the sequence of integers P(n)
# defined by the initial values.
# 
# P(0) = P(1) = P(2) = 1
# 
# and then followed by
# 
# P(n) = P(n-2) + P(n-3)
# 
# First few Padovan Numbers are as below:
# 
# 1, 1, 1, 2, 2, 3, 4, 5, 7, 9, 12, 16, 21, 28, 37, ...
# 
# Write a script to compute first 10 distinct Padovan Primes.
#
# Expected Output
# 
# 2, 3, 5, 7, 37, 151, 3329, 23833, 13091204281, 3093215881333057
# 
# MY NOTES: ok, Padovan numbers are rather like Fibonacci numbers,
# and easy enought to calculate.  Then we must check isprime().
# Should be pretty easy in principle, but in practice I note how big
# the answers get very quickly, this code finds the first 8 Padovan
# Primes but would take ludicrously long amounts of time - and ludicrously
# large amounts of RAM to store all the prime numbers.  It's never
# finished for N==9 or 10.
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Function::Parameters;
#use Data::Dumper;

use lib qw(.);
use MakePrimes;

my $debug=0;
die "Usage: first-N-padovan-primes [--debug] [N (default 10)]\n" unless
	GetOptions( "debug" => \$debug ) && @ARGV<2;
my $n = shift // 10;

prime_debug( $debug );

# Padovan sequence:

my @pad = (1,1,1);

#
# my $p = nextpad();
#	Extend @pad by one, pad(n) = pad(n-2) + pad(n-3)
#	return the newest (last) element.
#
fun nextpad(  )
{
	my $n = @pad;
	$pad[$n] = $pad[$n-2] + $pad[$n-3];
	return $pad[$n];
}


#
# my @pp = find_first_n_pad_primes( $n );
#	Find and return the first $n Padovan primes,
#	calculating primes along the way.
#
fun find_first_n_pad_primes( $n )
{
	my $band = 1000000;
	my @result;

	my $upto = $band;
	my %isprime;
	$isprime{$_}++ for primes_upto( $upto );
	my %seen;
	for(;;)
	{
		my $x = nextpad();
		if( $x > $upto )		# need more primes
		{
			my $newupto = $upto + $band;
			$isprime{$_}++ for more_primes( $upto, $newupto );
			$upto = $newupto;
		}
		next unless $isprime{$x};	# find Prime Pad nos
		next if $seen{$x}++;		# remove duplicates
		push @result, $x;
		my $nfound = @result;
		say "debug: found ${nfound}th pp: $x"; # if $debug;

		return @result if @result==$n;
	}
}

my @pp = find_first_n_pad_primes( $n );

say join( ', ', @pp );
