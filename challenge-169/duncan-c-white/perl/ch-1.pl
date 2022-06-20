#!/usr/bin/perl
# 
# TASK 1: Brilliant Numbers
# 
# Write a script to generate first 20 Brilliant Numbers.
# 
#     Brilliant numbers are numbers with two prime factors of the same length.
# 
# The number should have exactly two prime factors, i.e. it's the product
# of two primes of the same length.
# 
# For example,
# 
# 24287 = 149 x 163
# 24289 = 107 x 227
# 
# Therefore 24287 and 24289 are 2-brilliant numbers.  These two brilliant
# numbers happen to be consecutive as there are no even brilliant numbers
# greater than 14.
# 
# Output
# 
# 4, 6, 9, 10, 14, 15, 21, 25, 35, 49, 121, 143, 169, 187, 209, 221, 247, 253, 289, 299
# 
# MY NOTES: ok, sounds relatively easy, but I'm getting very bored of
# "tasks to do with Number Theory and (especially) Primes".  Reuse the
# PrimeFactors module from last week, the one that doesn't pre-compute
# primes up to X.
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
#use Data::Dumper;

use lib qw(.);
use PrimeFactors;

my $debug=0;
die "Usage: brilliant-numebrs [--debug] [N default 20]\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV<2;
my $n = shift // 20;

my @brillig;
for( my $x = 4; @brillig < $n; $x++ )
{
	my @f = prime_factors( $x );
	next unless @f == 2;
	next unless length($f[0]) == length($f[1]);
	push @brillig, $x;
	say "found briliant number $x, factors $f[0] x $f[1]" if $debug;
}

say join(', ', @brillig );
