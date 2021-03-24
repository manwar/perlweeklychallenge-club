#!/usr/bin/perl

# Challenge 105
#
# TASK #1 › Nth root
# Submitted by: Mohammad S Anwar
# You are given positive numbers $N and $k.
#
# Write a script to find out the $Nth root of $k. For more information, please
# take a look at the wiki page.
#
# Example
# Input: $N = 5, $k = 248832
# Output: 12
#
# Input: $N = 5, $k = 34
# Output: 2.02

use strict;
use warnings;
use 5.030;

my($n, $k) = @ARGV;
say $k ** (1/$n);
