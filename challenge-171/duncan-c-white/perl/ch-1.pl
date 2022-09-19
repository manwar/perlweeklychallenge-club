#!/usr/bin/perl
# 
# Task 1: Abundant Number
# 
# Write a script to generate first 20 Abundant Odd Numbers.
# 
# According to wikipedia: A number n for which the sum of proper divisors
# (divisors from 1 but less than n) s(n) > n.
# 
# For example, 945 is the first Abundant Odd Number.
# 
# Sum of divisors:
# 1 + 3 + 5 + 7 + 9 + 15 + 21 + 27 + 35 + 45 + 63 + 105 + 135 + 189 + 315 = 975
# 
# MY NOTES: ok, sounds easy, and at least it's nowt to do with Primes:-)
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

my $debug=0;
die "Usage: odd-abundant-numbers [--debug] [N default 20]\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV<2;
my $n = shift // 20;

#
# my @f = factors_less_than_n( $n );
#	Find and return an array of all the factors of $n
#	including 1 but less than $n.
#
sub factors_less_than_n
{
	my( $n ) = @_;
	my @f;
	for( my $i=1; $i<$n; $i++ )
	{
		push @f, $i if $n%$i==0;
	}
	return @f;
}


my @oa;		# the first few Odd Abundant numbers we find

for( my $i = 3; @oa<$n; $i+=2 )
{
	my @f = factors_less_than_n( $i );
	my $sum = sum0(@f);
	say "i=$i, factors = ". join(',',@f). ", sum=$sum" if $debug;
	next if $sum <= $i;
	say "found odd abdundant no $i" if $debug;
	push @oa, $i;
}

say for @oa;
