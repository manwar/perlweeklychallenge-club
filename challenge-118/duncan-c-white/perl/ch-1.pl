#!/usr/bin/perl
# 
# Task 1: "Binary Palindrome
# 
# You are given a positive integer $N.
# 
# Write a script to find out if the binary representation of the given
# integer is Palindrome. Print 1 if it is otherwise 0.
# 
# Example
# 
#   Input: $N = 5
#   Output: 1 as binary representation of 5 is 101 which is Palindrome.
# 
#   Input: $N = 4
#   Output: 0 as binary representation of 4 is 100 which is NOT Palindrome.
# "
# 
# My notes: seems pretty easy.
# 
# 

use strict;
use warnings;
use feature 'say';
#use Data::Dumper;

my $debug = 0;
die "Usage: binary-palindrome N\n" unless @ARGV == 1;
my $n = shift;

my $b = sprintf( "%b", $n );
my $bpal = ($b eq reverse $b) ? 1 : 0;
say $bpal;
