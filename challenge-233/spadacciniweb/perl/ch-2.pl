#!/usr/bin/env perl

# Task 2: Frequency Sort
# Submitted by: Mohammad S Anwar
# 
# You are given an array of integers.
# Write a script to sort the given array in increasing order based on the frequency of the values. If multiple values have the same frequency then sort them in decreasing order.
#
# Example 1
# Input: @ints = (1,1,2,2,2,3)
# Ouput: (3,1,1,2,2,2)
# 
# '3' has a frequency of 1
# '1' has a frequency of 2
# '2' has a frequency of 3
# 
# Example 2
# Input: @ints = (2,3,1,3,2)
# Ouput: (1,3,3,2,2)
# 
# '2' and '3' both have a frequency of 2, so they are sorted in decreasing order.
# 
# Example 3
# Input: @ints = (-1,1,-6,4,5,-6,1,4,1)
# Ouput: (5,-1,4,4,-6,-6,1,1,1)
# 
# You are given a list of passenger details in the form “9999999999A1122”, where 9 denotes the phone number, A the sex, 1 the age and 2 the seat number.

use strict;
use warnings;

my @input = @ARGV;
die "Input error\n"
    if scalar @input < 1
       or
       (scalar map { $_ =~ /[\-\d]/ ? () : 1 }
                 @input) != 0;

my %freq;
$freq{$_}++
    foreach @input;


printf "(%s) -> %s \n", (join ', ', @input),
                        join ', ', sort { $freq{$a} <=> $freq{$b} || $b <=> $a } @input;
