#!/usr/bin/perl
#
# Task 1: "Digits Sum
#
# You are given two positive numbers $N and $S.
# 
# Write a script to list all positive numbers having exactly $N digits
# where sum of all digits equals to $S.
# 
# Example
# 
# Input:
#     $N = 2
#     $S = 4
# 
# Output:
#     13, 22, 31, 40
# "
# 
# My notes: sounds like fun.
#

use strict;
use warnings;
use feature 'say';
use Function::Parameters;
use Data::Dumper;
use List::Util qw(sum);

#
# my $sum = digitsum($x);
#	Compute the sum of all decimal digits of $x.
#
fun digitsum( $x )
{
	my $sum = sum( split(//,$x) );
	return $sum;
}


die "Usage: digits-sum NDIGITS DIGITSUM\n" unless @ARGV==2;
my( $ndigits, $digitsum ) = @ARGV;

my $lo = 10**($ndigits-1);
my $hi = 10*$lo-1;

foreach my $i ($lo..$hi)
{
	next unless digitsum($i) == $digitsum;
	say $i;
}
