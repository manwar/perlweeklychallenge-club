#!/usr/bin/perl
# 
# TASK #1 - Additive Primes
# 
# Write a script to find out all Additive Primes <= 100.
# 
# Additive primes are prime numbers for which the sum of their decimal
# digits are also primes.
# 
# Output
# 
# 	2, 3, 5, 7, 11, 23, 29, 41, 43, 47, 61, 67, 83, 89
# 
# MY NOTES: ok.  Pretty easy.  Reuse my MakePrimes module, and code up
# isprime(n) and isprime(sum_digits(n))
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use List::Util qw(sum0);
#use Data::Dumper;

use lib qw(.);
use MakePrimes;

my $debug=0;
die "Usage: additiive-primes [--debug] [limit] (default 100)\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV<2;

my $limit = shift // 100;

my @primes = primes_upto( $limit );
my %isprime = map { $_ => 1 } @primes;

my @addprimes = grep { $isprime{ sum0( split(//,$_) ) } } @primes;

say join(', ', @addprimes);
