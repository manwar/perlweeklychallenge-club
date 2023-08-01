#!/usr/bin/env perl

# Task 1: Unique Sum
# Submitted by: Mohammad S Anwar
# 
# You are given an array of integers.
# Write a script to find out the sum of unique elements in the given array.
#
# Example 1
# Input: @int = (2, 1, 3, 2)
# Output: 4
# 
# In the given array we have 2 unique elements (1, 3).
# 
# Example 2
# Input: @int = (1, 1, 1, 1)
# Output: 0
# 
# In the given array no unique element found.
# 
# Example 3
# Input: @int = (2, 1, 3, 4)
# Output: 10
# 
# In the given array every element is unique.

use strict;
use warnings;
use List::Util qw/ sum /;

my @input = @ARGV;
die "Input error\n"
    if scalar @input < 1
       or
       (scalar map { $_ =~ /[\-\d]/ ? () : 1 }
                 @input) != 0;

my %int;
foreach my $i (@input) {
    $int{$i}++;
}

printf "Output: %d\n", sum map { $int{$_} == 1 ? $_ : ()  } keys %int;
