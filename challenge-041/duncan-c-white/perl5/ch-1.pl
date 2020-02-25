#!/usr/bin/perl
#
# Task 1: "Write a script to display attractive numbers between 1 and 50.
# 
# A number is an attractive number if the number of its prime factors is
# also prime number.
# 
# For example: The number 20 is an attractive number, whose prime factors
# are 2, 2 and 5. The total prime factors is 3 which is also a prime number.
# "
# 
# My notes: Think I have a prime-factors finder from an earlier challenge;
# should be easy given that.
#

use v5.10;	# to get "say"
use strict;
use warnings;
use Function::Parameters;
#use Data::Dumper;

use lib qw(.);	# I hate this!
use MakePrimes;
use PrimeFactors;

die "Usage: ch-1.pl [N//50]\n" if @ARGV>1;

my $n = shift // 50;

my @primes = primes_upto( $n );
my %isprime = map { $_ => 1 } @primes;

foreach my $x (2..$n)
{
	my @factors = prime_factors( $x, @primes );
	my $nf = @factors;
	next unless $isprime{$nf};
	say "$x is an attractive number, factors are: ", join(',',@factors),
	    ", number factors $nf is prime";
}

