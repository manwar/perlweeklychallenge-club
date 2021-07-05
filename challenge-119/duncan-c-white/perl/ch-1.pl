#!/usr/bin/perl
# 
# Task 1: "Swap Nibbles
# 
# You are given a positive integer $N.
# 
# Write a script to swap the two nibbles of the binary representation
# of the given number and print the decimal number of the new binary
# representation.
# 
# A nibble is a four-bit aggregation, or half an octet.
# 
# To keep the task simple, we only allow integer less than or equal to 255.
# 
# Example
# 
#   Input: $N = 101
#   Output: 86
# 
#   Binary representation of decimal 101 is 1100101 or, as 2 nibbles,
#   (0110)(0101). The swapped nibbles would be (0101)(0110) - decimal 86.
# 
#   Input: $N = 18
#   Output: 33
# 
#   Binary representation of decimal 18 is 10010 or as 2 nibbles (0001)(0010).
#   The swapped nibbles would be (0010)(0001) same as decimal 33.
# "
# 
# My notes: trivial.
# 

use strict;
use warnings;
use feature 'say';
#use Data::Dumper;

my $debug = 0;
die "Usage: swap-nibbles N\n" unless @ARGV == 1;
my $n = shift;
die "swap-nibbles: N ($n) must be 0..255\n" unless $n>=0 && $n<=255;

my $l = $n & 15;
my $h = ($n>>4) & 15;
my $swap = $l<<4 | $h;
say $swap;
