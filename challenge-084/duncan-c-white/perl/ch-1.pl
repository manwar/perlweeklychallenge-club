#!/usr/bin/perl
#
# Task 1: "Reverse Integer
#
# You are given an integer $N.
# 
# Write a script to reverse the given integer and print the result. Print
# 0 if the result doesn't fit in 32-bit signed integer.
# 
# The number 2,147,483,647 is the maximum positive value for a 32-bit
# signed binary integer in computing.
# 
# Example 1:
# 
# 	Input: 1234
# 	Output: 4321
# 
# Example 2:
# 
# 	Input: -1234
# 	Output: -4321
# 
# Example 3:
# 
# 	Input: 1231230512
# 	Output: 0
# 
# My notes: simple, clearly defined: only tricky bit is the overflow detection
# as Perl **doesn't** use 32bit integers.
#

use strict;
use warnings;
use feature 'say';
use Data::Dumper;

die "Usage: reverse-integer N\n" unless @ARGV==1;
my $n = shift;

my $maxint = 2147483647;

my $result = "";
if( $n < 0 )
{
	$n = -$n;
	$result = "-";
}
die "n bigger than maxint\n" if $n > $maxint;

my $rev = join('', reverse split(//,$n) );

$result .= $rev;
$result = 0 if $rev > $maxint;
say $result;
