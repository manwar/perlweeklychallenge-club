#!/usr/bin/env perl

# Challenge 240
#
# Task 2: Build Array
# Submitted by: Mohammad S Anwar
#
# You are given an array of integers.
#
# Write a script to create an array such that new[i] = old[old[i]] where 0 <= i < new.length.
# Example 1
#
# Input: @int = (0, 2, 1, 5, 3, 4)
# Output: (0, 1, 2, 4, 5, 3)
#
# Example 2
#
# Input: @int = (5, 0, 1, 2, 3, 4)
# Output: (4, 5, 0, 1, 2, 3)

use Modern::Perl;

@ARGV or die "Usage: $0 n n n...\n";

my @old = @ARGV;
my @new;
for my $i (0..$#old) {
    $new[$i] = $old[$old[$i]];
}
say "@new";
