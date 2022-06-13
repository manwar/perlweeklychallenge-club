#!/usr/bin/perl
# 
# TASK 1: Perrin Prime
# 
# The Perrin sequence is defined to start with [3, 0, 2]; after that, term
# N is the sum of terms N-2 and N-3. (So it continues 3, 2, 5, 5, 7, ....)
# 
# A Perrin prime is a number in the Perrin sequence which is also a prime
# number.
# 
# Calculate the first 13 Perrin Primes.
# 
# f(13) = [2, 3, 5, 7, 17, 29, 277, 367, 853, 14197, 43721, 1442968193, 792606555396977]
# 
# MY NOTES: ok, sounds relatively easy, except that the 12th and 13th PP are
# enormous.  I normally reusing my old favourite MakePrimes.pm (Sieve of
# Eratosthenes based) but this time I think I'll have to do it the old
# fashioned "try all factors up to sqrt()" approach.
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
#use Data::Dumper;

use lib qw(.);
use PrimeFactors;

my $debug=0;
die "Usage: perrin-prime [--debug] [N default 13]\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV<2;
my $n = shift // 13;

my @perrin = qw(3 0 2);
my %result = map { $_ => 1 } qw(2 3);

while( keys %result < $n )
{
	# get next perrin number
	my $np = $perrin[-2] + $perrin[-3];
	push @perrin, $np;
	say "next perrin no is $np" if $debug;
	$result{$np}++ if isprime($np);
}

say "f($n) = [ ".join(',', sort { $a <=> $b } keys %result )." ]";
