#!/usr/bin/env perl

# Task 2: Array Pairings
# Submitted by: Mohammad S Anwar
# 
# You are given an array of integers having even number of elements..
# Write a script to find the maximum sum of the minimum of each pairs.
# 
# Example 1
# Input: @array = (1,2,3,4)
# Output: 4
# 
# Possible Pairings are as below:
# a) (1,2) and (3,4). So min(1,2) + min(3,4) => 1 + 3 => 4
# b) (1,3) and (2,4). So min(1,3) + min(2,4) => 1 + 2 => 3
# c) (1,4) and (2,3). So min(1,4) + min(2,3) => 2 + 1 => 3
# 
# So the maxium sum is 4.
# 
# Example 2
# Input: @array = (0,2,1,3)
# Output: 2
# 
# Possible Pairings are as below:
# a) (0,2) and (1,3). So min(0,2) + min(1,3) => 0 + 1 => 1
# b) (0,1) and (2,3). So min(0,1) + min(2,3) => 0 + 2 => 2
# c) (0,3) and (2,1). So min(0,3) + min(2,1) => 0 + 1 => 1
# 
# So the maximum sum is 2.

use strict;
use warnings;
use Algorithm::Combinatorics qw(partitions);
use List::Util qw(min max sum);

my @input = @ARGV;
die "Input error\n"
    if scalar @input < 1
       or
       (scalar @input) % 2 != 0
       or
       (scalar map { $_ =~ /\D/ ? 1 : () }
                @input) != 0;

my @pairing;
my $iter = partitions([map { int($_) } @input], (scalar @input/2));
while (my $p = $iter->next) {
    my $bool = 1;
    foreach my $set (@$p) {
        if (scalar @$set != 2) {
            $bool = 0;
            last;
        }
    }
    push @pairing, $p
        if $bool;
}

my @min;
foreach my $pairs (@pairing) {
    push @min, sum map { min @{$_} }
                     values @$pairs;
}
printf "%s\n", max @min;
