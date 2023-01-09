#!/usr/bin/perl
# 
# Task 2: Prime Count
# 
# You are given an integer $n > 0.
# 
# Write a script to print the count of primes less than $n.
# Example 1
# 
# Input: $n = 10
# Output: 4 as in there are 4 primes less than 10 are 2, 3, 5 ,7.
# 
# Example 2
# 
# Input: $n = 15
# Output: 6
# 
# Example 3
# 
# Input: $n = 1
# Output: 0
# 
# Example 4
# 
# Input: $n = 25
# Output: 9
# 
# MY NOTES: very easy, specially if you have a prime finding module lying
# around:-)
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Function::Parameters;
use Data::Dumper;

use lib qw(.);
use MakePrimes;

my $debug=0;
die "Usage: prime-count [--debug] N\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV==1;

my $n = shift;

die "prime-count: N must be > 0\n" if $n < 1;

my @primes = primes_upto( $n-1 );

say scalar @primes;
