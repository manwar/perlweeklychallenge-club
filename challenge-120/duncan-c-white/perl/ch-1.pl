#!/usr/bin/perl
# 
# Task 1: "Swap Odd/Even bits
# 
# You are given a positive integer $N less than or equal to 255.
# 
# Write a script to swap the odd positioned bit with even positioned bit
# and print the decimal equivalent of the new binary representation.
# 
# Example
# 
#   Input: $N = 101
#   Output: 154
# 
#   Binary representation of the given number is 01 10 01 01.
#   The new binary representation after the odd/even swap is 10 01 10 10.
#   The decimal equivalent of 10011010 is 154.
# 
#   Input: $N = 18
#   Output: 33
# 
#   Binary representation of the given number is 00 01 00 10.
#   The new binary representation after the odd/even swap is 00 10 00 01.
#   The decimal equivalent of 100001 is 33.
# "
# 
# My notes: trivial again.
# 

use strict;
use warnings;
use feature 'say';
#use Data::Dumper;

my $debug = 0;
die "Usage: swap-odd-even-bits N\n" unless @ARGV == 1;
my $n = shift;
die "swap-odd-even-bits: N ($n) must be 0..255\n" unless $n>=0 && $n<=255;

my @swap = ( 0, 2, 1, 3 );	# 2-bit integer index -> reverse-2-bit value

my $a = $n & 3;
my $b = ( $n >> 2 ) & 3;
my $c = ( $n >> 4 ) & 3;
my $d = ( $n >> 6 ) & 3;

my $rev = $swap[$a] | ($swap[$b]<<2) | ($swap[$c]<<4) | ($swap[$d]<<6);
say $rev;
