#!/usr/bin/perl
# 
# Task 1: Prime Partition
# 
# You are given two positive integers, $m and $n.
# 
# Write a script to find out the Prime Partition of the given number $m that
# contains $n elements. No duplicates allowed.
# 
# For example,
# 
#   Input: $m = 18, $n = 2
#   Output: 5, 13 or 7, 11
# 
#   Input: $m = 19, $n = 3
#   Output: 3, 5, 11
# 
# MY NOTES: ok, sounds quite easy, even if it is to do with Primes.  Without
# duplicates means that each prime p < m is either present or absent in a
# given partition, so we can use our old trick of having a counting loop from
# 0..2**(nitems)-1 and compute the sum of just those items selected by the
# binary bits of the count that are 1 (then check that the sum is $m and
# the number of elements being summed is $n)
# 
# GUEST LANGUAGE: As a bonus, I also had a go at translating ch-1.pl
# into C (look in the C directory for that).
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Data::Dumper;
use List::Util qw(sum0);

use lib qw(.);
use MakePrimes;

my $debug=0;
die "Usage: prime-partition [--debug] M N\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV==2;
my( $m, $n ) = @ARGV;

my @primes = primes_upto( $m-1 );
my $nitems = @primes;

my @pp;	# array of prime partitions, each a string

my $two2n = 2**$nitems;

for( my $i=0; $i<$two2n; $i++ )
{
	my $b = sprintf("%0${nitems}b", $i );
	my @select = split( //, $b );

	my @chosen = map { $primes[$_] } grep { $select[$_] } 0..$nitems-1;
	my $sum = sum0(@chosen);
	#say "$i: b=$b, select=", join(',',@select),
	#    ", chosen=", join(',',@chosen),
	#    ", sum=$sum" if $debug;
	next unless $sum == $m;
	next unless @chosen == $n;
	say "$i: b=$b, found a pp: ", join(',',@chosen) if $debug;
	push @pp, join( ', ', @chosen);
}

my $str = join( ' or ', @pp );
say $str;
