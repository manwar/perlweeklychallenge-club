#!/usr/bin/perl
#
# Task 1: "Trailing Zeroes
#
# You are given a positive integer $N (<= 10).
# 
# Write a script to print number of trailing zeroes in $N!.
# 
# Example 1
# Input: $N = 10
# Output: 2 as $N! = 3628800 has 2 trailing zeroes
# 
# Example 2
# Input: $N = 7
# Output: 1 as $N! = 5040 has 1 trailing zero
# 
# Example 3
# Input: $N = 4
# Output: 0 as $N! = 24 has 0 trailing zero
# 
# "
# 
# My notes: ok.  Very easy.  fact and "while mod 10 == 0 inc & div 10"
# 

use strict;
use warnings;
use feature 'say';
#use Function::Parameters;
#use Data::Dumper;

die "Usage: fact-trailing-zeroes N\n" unless @ARGV==1;
my( $n ) = @ARGV;

die "fact-trailing-zeroes: N must be >= 0 ($n given)\n" unless $n>=0;

my $fact = 1;
$fact *= $_ for 1..$n;
say "fact(n) = $fact";

# trailing zeroes of fact
my $tz = 0;
my $i = $fact;
while( $i % 10 == 0 )
{
	$i /= 10;
	$tz++;
}
say "trailing zeroes($fact) = $tz";
