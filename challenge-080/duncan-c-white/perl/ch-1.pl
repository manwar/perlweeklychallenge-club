#!/usr/bin/perl
#
# 
# Task 1: "Smallest Positive Number
# 
# You are given unsorted list of integers @N.
# 
# Write a script to find out the smallest positive number missing.
# Example 1:
# 
#   Input: @N = (5, 2, -2, 0)
#   Output: 1
# 
# Example 2:
# 
#   Input: @N = (1, 8, -1)
#   Output: 2
# 
# Example 3:
# 
#   Input: @N = (2, 0, -1)
#   Output: 1
# "
# 
# My notes: ok. very straightforward.  Is it worth forming a set of values
# for more efficient "is 1 a member?"  "is 2 a member?" etc? probably:-)
#

use strict;
use warnings;
use feature 'say';
use Function::Parameters;
use Data::Dumper;

die "Usage: smallest-+ve list_of_ints\n" unless @ARGV>=1;

my %set = map { $_ => 1 } @ARGV;

my $n;
for( $n=1; $set{$n}; $n++ )
{
}
say $n;
