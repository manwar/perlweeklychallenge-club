#!/usr/bin/env perl

# Task 1: 33% Appearance
# Submitted by: Mohammad Sajid Anwar
# 
# You are given an array of integers, @ints.
# Write a script to find an integer in the given array that appeared 33% or more. If more than one found, return the smallest. If none found then return undef.
# Example 1
# 
# Input: @ints = (1,2,3,3,3,3,4,2)
# Output: 3
# 
# 1 appeared 1 times.
# 2 appeared 2 times.
# 3 appeared 4 times.
# 
# 3 appeared 50% (>33%) in the given array.
# 
# Example 2
# Input: @ints = (1,1)
# Output: 1
# 
# 1 appeared 2 times.
# 1 appeared 100% (>33%) in the given array.
# 
# Example 3
# Input: @ints = (1,2,3)
# Output: 1
# 
# 1 appeared 1 times.
# 2 appeared 1 times.
# 3 appeared 1 times.
# 
# Since all three appeared 33.3% (>33%) in the given array.
# We pick the smallest of all.

use strict;
use warnings;
use List::Util qw/ min /;

my @ints = (1,2,3,3,3,3,4,2);
appearance(\@ints);

@ints = (1,1);
appearance(\@ints);

@ints = (1,2,3);
appearance(\@ints);

exit 0;

sub appearance {
    my $ints = shift;

    my %ints;
    $ints{$_}++
        foreach @$ints;

     printf "(%s) -> %s\n",
        (join ',', @$ints),
        min ( grep { $ints{$_} / (scalar @$ints) >= 0.33 } keys %ints );
}
