#!/usr/bin/perl
# 
# TASK #1 - Two Friendly
# 
# You are given 2 positive numbers, $m and $n.
# 
# Write a script to find out if the given two numbers are Two Friendly.
# 
# Two positive numbers, m and n are two friendly when gcd(m, n) = 2 ^
# p where p > 0. The greatest common divisor (gcd) of a set of numbers
# is the largest positive number that divides all the numbers in the set
# without remainder.
# 
# Example 1
# 
#     Input: $m = 8, $n = 24
#     Output: 1
# 
#     Reason: gcd(8,24) = 8 => 2 ^ 3
# 
# Example 2
# 
#     Input: $m = 26, $n = 39
#     Output: 0
# 
#     Reason: gcd(26,39) = 13
# 
# Example 3
# 
#     Input: $m = 4, $n = 10
#     Output: 1
# 
#     Reason: gcd(4,10) = 2 => 2 ^ 1
# 
# MY NOTES: Pretty easy.  Euclid's GCD algorithm, then check if the result is a power of 2.
#

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Function::Parameters;
#use Data::Dumper;


#
# my $gcd = gcd( $a, $b );
#       Compute and return the GCD (Greatest Common Denominator) of $a and $b.
#
fun gcd( $a, $b )
{
        while( $b != 0 )
        {
                ( $a, $b ) = ( $b, $a % $b );
        }
        return $a;
}


my $debug=0;
die "Usage: 2-friendly N M\n" unless
	GetOptions( "debug"=>\$debug ) && @ARGV==2;
my( $n, $m ) = @ARGV;

my $gcd = gcd( $n, $m );
say "gcd is $gcd" if $debug;

my $ispower = 0;
for( my $twop = 2; $twop <= $gcd; $twop *= 2 )
{
	$ispower++ if $twop == $gcd;
}

say $ispower;
