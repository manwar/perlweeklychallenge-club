#!/usr/bin/env perl

# Task 1: Fun Sort
# Submitted by: Mohammad S Anwar
# 
# You are given a list of positive integers.
# Write a script to sort the all even integers first then all odds in ascending order.
# 
# Example 1
# Input: @list = (1,2,3,4,5,6)
# Output: (2,4,6,1,3,5)
# 
# Example 2
# Input: @list = (1,2)
# Output: (2,1)
# 
# Example 3
# Input: @list = (1)
# Output: (1)

use strict;
use warnings;

my @input = @ARGV;
die "Input error\n"
    if scalar @input < 1
       or
       (scalar map { $_ =~ /\D/ ? 1 : () }
                 @input) != 0;

my @list = sort { $b <=> $a } map { $_ % 2 == 0 ? $_ : () } @input;
push @list, sort { $b <=> $a } map { $_ % 2 ? $_ : () } @input;
printf "(%s)\n", join ',', @list;
