#!/usr/bin/perl
# 
# Task 1: Binary Flip
# 
# You are given a positive integer, $n.
# 
# Write a script to find the binary flip.
#
# Example 1
#
# Input: $n = 5
# Output: 2
# 
# First find the binary equivalent of the given integer, 101.
# Then flip the binary digits 0 -> 1 and 1 -> 0 and we get 010.
# So Binary 010 => Decimal 2.
# 
# Example 2
# 
# Input: $n = 4
# Output: 3
# 
# Decimal 4 = Binary 100
# Flip 0 -> 1 and 1 -> 0, we get 011.
# Binary 011 = Decimal 3
# 
# Example 3
# 
# Input: $n = 6
# Output: 1
# 
# Decimal 6 = Binary 110
# Flip 0 -> 1 and 1 -> 0, we get 001.
# Binary 001 = Decimal 1
# 
# MY NOTES: very easy.  That's ones complement with a bit of range-fixing!
# 
# GUEST LANGUAGE: As a bonus, I also had a go at translating ch-1.pl
# into C (look in the C directory for the translation)
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Data::Dumper;

my $debug=0;
die "Usage: binary-flip [--debug] N\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV==1;

my $n = shift;
$n += 0;

my $p = 1;
while( $p < $n )
{
	$p *= 2;
}

$n = (~ $n) & ($p-1);
say "$n";
