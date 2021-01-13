#!/usr/bin/env perl
use strict;
use warnings;
use feature qw(:5.32);
use experimental qw(signatures);

# TASK #1 › Leader Element
# Submitted by: Mohammad S Anwar
#
# You are given an array @A containing distinct integers.
#
# Write a script to find all leader elements in the array @A. Print
# (0) if none found.
#
#     An element is leader if it is greater than all the elements to
#     its right side.
#
# Example 1:
#
# Input: @A = (9, 10, 7, 5, 6, 1)
# Output: (10, 7, 6, 1)
#
# Example 2:
#
# Input: @A = (3, 4, 5)
# Output: (5)

my @a = @ARGV;
my $max;
my @out;

for (my $i = $#a; $i >= 0; $i--) {
    if (!defined $max || $a[$i] > $max) {
        unshift @out, $a[$i];
        $max = $a[$i];
    }
}

say "@out";
