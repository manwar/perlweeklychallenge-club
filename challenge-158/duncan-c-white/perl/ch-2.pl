#!/usr/bin/perl
# 
# TASK #2 - First Series Cuban Primes
# 
# Write a script to compute first series Cuban Primes <= 1000. Please
# refer to https://en.wikipedia.org/wiki/Cuban_prime
# for more information.
# 
# [That says: p = (y+1)**3 - y**3 for y>0, or p = 3y**2 + 3y + 1 for y>0]
# 
# Output
# 
# 	7, 19, 37, 61, 127, 271, 331, 397, 547, 631, 919.
# 
# MY NOTES: ok.  Not quite clear from Wikipedia page whether 3y**2 + 3y + 1
# for all y>0 is prime, I assume that's not true, so that we have to check
# isprime(3y**2 + 3y + 1)
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
#use Data::Dumper;

use lib qw(.);
use MakePrimes;

my $debug=0;
die "Usage: first-cuban-primes [--debug] [limit] (default 1000)\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV<2;

my $limit = shift // 1000;

my @primes = primes_upto( $limit );
my %isprime = map { $_ => 1 } @primes;

my @cuban1primes;
for( my $y=1; ; $y++ )
{
	my $cubediff = 3 * $y * $y + 3 * $y + 1;
	last if $cubediff > $limit;
	push @cuban1primes, $cubediff if $isprime{$cubediff};
}

say join(', ', @cuban1primes);
