#!/usr/bin/perl
#
# Task 1: "Palindrome Number
# 
# You are given a number $N.
# Write a script to figure out if the given number is Palindrome.
# Print 1 if true otherwise 0.
# 
# Example 1:
# 
# 	Input: 1221
# 	Output: 1
# 
# Example 2:
# 
# 	Input: -101
# 	Output: 0, since -101 and 101- are not the same.
# 
# Example 3:
# 
# 	Input: 90
# 	Output: 0
# "
# 
# My notes: sounds trivial.  N == join(reverse(split(N)))
# 

use strict;
use warnings;
use feature 'say';
use Data::Dumper;
use Function::Parameters;

die "Usage: palindrome N\n" unless @ARGV==1;
my $n = shift;

#
# my $ispal = palindrome($n);
#	Return 1 if $n is a palindrome, 0 otherwise.
#
fun palindrome( $n )
{
	return $n eq join('', reverse( split( //, $n ) ) ) ? 1 : 0;
}


my $ispal = palindrome($n);
say $ispal;
