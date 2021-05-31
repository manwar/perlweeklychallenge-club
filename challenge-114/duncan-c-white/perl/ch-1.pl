#!/usr/bin/perl
# 
# Task 1: "Next Palindrome Number
# 
# You are given a positive integer $N.
# 
# Write a script to find out the next Palindrome Number higher than the given integer $N.
# 
# Example
# 
#   Input: $N = 1234
#   Output: 1331
# 
#   Input: $N = 999
#   Output: 1001
# "
# 
# My notes: sounds very simple.  Generate and test for palindromic-ness.
# 

use strict;
use warnings;
use feature 'say';
use Function::Parameters;
#use Data::Dumper;

#
# my $ispal = ispalindromic( $n );
#	Return 1 iff $n is palindromic (in decimal of course)
#
fun ispalindromic( $n )
{
	my $rev = join( '', reverse split( //, $n ) );
	return $n==$rev ? 1 : 0;
}




die "Usage: next-palindromic-number N\n" unless @ARGV==1;
my $n = shift;

do
{
	$n++;
}
while( ! ispalindromic($n) );

say $n;
