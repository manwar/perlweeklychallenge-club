#!/usr/bin/env perl

# Challenge 241
#
# Task 1: Arithmetic Triplets
# Submitted by: Mohammad S Anwar
#
# You are given an array (3 or more members) of integers in increasing order
# and a positive integer.
#
# Write a script to find out the number of unique Arithmetic Triplets satisfying
# the following rules:
#
# a) i < j < k
# b) nums[j] - nums[i] == diff
# c) nums[k] - nums[j] == diff
#
# Example 1
#
# Input: @nums = (0, 1, 4, 6, 7, 10)
#        $diff = 3
# Output: 2
#
# Index (1, 2, 4) is an arithmetic triplet because both  7 - 4 == 3 and 4 - 1 == 3.
# Index (2, 4, 5) is an arithmetic triplet because both 10 - 7 == 3 and 7 - 4 == 3.
#
# Example 2
#
# Input: @nums = (4, 5, 6, 7, 8, 9)
#        $diff = 2
# Output: 2
#
# (0, 2, 4) is an arithmetic triplet because both 8 - 6 == 2 and 6 - 4 == 2.
# (1, 3, 5) is an arithmetic triplet because both 9 - 7 == 2 and 7 - 5 == 2.

use Modern::Perl;

# parse args
sub usage { return "Usage: $0 -nums n n n ... -diff n\n"; }

my(@nums, $diff);
while (@ARGV) {
    if ($ARGV[0] eq "-nums") {
        shift;
        while (@ARGV && $ARGV[0] !~ /^-/) {
            push @nums, shift;
        }
    }
    elsif ($ARGV[0] eq "-diff") {
        shift;
        $diff = shift;
    }
    else {
        die usage();
    }
}
if (!@nums || !$diff) { die usage(); }

# compute
my $count = 0;
for my $i (0 .. $#nums-2) {
    for my $j ($i+1 .. $#nums-1) {
        for my $k ($j+1 .. $#nums) {
            $count++ if ($nums[$j] - $nums[$i] == $diff &&
                         $nums[$k] - $nums[$j] == $diff);
        }
    }
}

# output
say $count;
