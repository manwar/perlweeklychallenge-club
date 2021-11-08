#!/usr/bin/perl
# 
# Task 1: "Invert Bit
# 
# You are given integers 0 <= $m <= 255 and 1 <= $n <= 8.
# 
# Write a script to invert $n bit from the end of the binary representation
# of $m and print the decimal representation of the new binary number.
# 
# Example
# 
#   Input: $m = 12, $n = 3
#   Output: 8
# 
# Binary representation of $m = 00001100
# Invert 3rd bit from the end = 00001000
# Decimal equivalent of 00001000 = 8
# 
#   Input $m = 18, $n = 4
#   Output: 26
# 
# Binary representation of $m = 00010010
# Invert 4th bit from the end = 00011010
# Decimal equivalent of 00011010 = 26
# "
# 
# My notes: trivial again.
# 

use strict;
use warnings;
use feature 'say';
#use Data::Dumper;

my $debug = 0;
die "Usage: invert-bit M N\n" unless @ARGV == 2;
my( $m, $n ) = @ARGV;
die "invert-bit: N ($n) must be 0..255\n" unless $n>=0 && $n<=255;
die "invert-bit: M ($m) must be 1..8\n" unless $n>=1 && $n<=8;

#printf "m=%08b\n", $m;
my $mask = (1 << ($n-1));
#say "mask=$mask";
$m = ($m & $mask ) ? ($m & ~$mask) : ($m | $mask);
#printf "m=%08b\n", $m;
say $m;
