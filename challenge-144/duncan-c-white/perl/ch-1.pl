#!/usr/bin/perl
# 
# TASK #1 - Semiprime
# 
# Write a script to generate all Semiprime number <= 100.
# 
# For more information about Semiprime, please checkout the wikipedia page
# https://en.wikipedia.org/wiki/Semiprime
# 
# In mathematics, a semiprime is a natural number that is the product of
# exactly two prime numbers. The two primes in the product may equal each
# other, so the semiprimes include the squares of prime numbers.
# 
# Example
# 
# 	10 is Semiprime as 10 = 2 x 5
# 	15 is Semiprime as 15 = 3 x 5
# 
# MY NOTES: Sounds easy, using my existing factors function, and
# my existing prime generation code.
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Data::Dumper;
use Function::Parameters;

use lib ".";
use MakePrimes;

my $debug=0;
my %isprime;


#
# my @div = divisors( $n );
#       Find and return all the divisors of $n, excluding 1.
#
fun divisors( $n )
{
        my @d = ();
        my $halfn = int($n/2);
        for( my $i=2; $i<=$halfn; $i++ )
        {
                push @d, $i if $n%$i==0;
        }
        return @d;
}


#
# my $issp = semiprime( $x );
#	Return 1 iff $x is semi-prime.
#
fun semiprime( $x )
{
	my @div = divisors( $x );
	push @div, $div[0] if @div == 1;
	return 0 unless @div == 2;
	return 0 unless $isprime{$div[0]} && $isprime{$div[1]};
	return 1;
}


die "Usage: semiprimes-lesseq-N [--debug] [N (default 100)]\n" unless
	GetOptions( "debug"=>\$debug ) && @ARGV<2;

my $n = shift // 100;

%isprime = map { $_ => 1 } primes_upto( $n );

my @sp;
for( my $i=1; $i<=$n; $i++ )
{
	push @sp, $i if semiprime($i);
}
say join(', ', @sp );
