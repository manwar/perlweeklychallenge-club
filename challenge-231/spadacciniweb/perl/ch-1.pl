#!/usr/bin/env perl

# Task 1: Min Max
# Submitted by: Mohammad S Anwar
# 
# You are given an array of distinct integers.
# Write a script to find all elements that is neither minimum nor maximum. Return -1 if you can’t.
#
# Example 1
# Input: @ints = (3, 2, 1, 4)
# Output: (3, 2)
# 
# The minimum is 1 and maximum is 4 in the given array. So (3, 2) is neither min nor max.
# 
# Example 2
# Input: @ints = (3, 1)
# Output: -1
# 
# Example 3
# Input: @ints = (2, 1, 3)
# Output: (2)
# 
# The minimum is 1 and maximum is 3 in the given array. So 2 is neither min nor max.


use strict;
use warnings;
use List::Util qw(min max);
no if $] >= 5.018, warnings =>  "experimental::smartmatch";

use Data::Dumper;

my @input = @ARGV;
die "Input error\n"
    if scalar @input < 1
       or
       (scalar map { $_ =~ /[\-\d]/ ? () : 1 }
                 @input) != 0;


my @others = map { $_ ~~ [(min @input), (max @input)] ? () : $_ }
                @input;
printf "Output: %s\n", (scalar @others)
                          ? sprintf '(%s)', join ', ', map { $_ } @others
                          : -1;
