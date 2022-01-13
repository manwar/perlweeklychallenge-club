#!/usr/bin/perl
# 
# TASK #1 - 10001st Prime Number
# 
# Write a script to generate the 10001st prime number.
# 
# (Remember that 2 is the 1st prime number).
# 
# 
# MY NOTES: Very easy, especially (tada) if you happen to have a prime
# generating module that you've already used several times in these
# challenges..
#

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Data::Dumper;

use lib qw(.);
use MakePrimes;

my $debug=0;
die "Usage: nth-prime [--debug] [N, default 10001]\n" unless
	GetOptions( "debug"=>\$debug ) && @ARGV<2;

my $n = shift // 10001;

prime_debug( $debug );

my $bandwidth = 10000;
my $upto = $bandwidth;
my @primes = primes_upto( $upto );

#die Dumper(\@primes);

my $primesfound = @primes;

while( $primesfound < $n )
{
	my $from = $upto;
	$upto += $bandwidth;
	my @moreprimes = more_primes( $from, $upto );
	push @primes, @moreprimes;
	$primesfound = @primes;
}

say $primes[$n-1];
