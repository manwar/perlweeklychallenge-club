#!/usr/bin/perl

# Challenge 199
#
# Task 1: Good Pairs
# Submitted by: Mohammad S Anwar
#
# You are given a list of integers, @list.
#
# Write a script to find the total count of Good Pairs.
#
#     A pair (i, j) is called good if list[i] == list[j] and i < j.
#
#
# Example 1
#
# Input: @list = (1,2,3,1,1,3)
# Output: 4
#
# There are 4 good pairs found as below:
# (0,3)
# (0,4)
# (3,4)
# (2,5)
#
# Example 2
#
# Input: @list = (1,2,3)
# Output: 0
#
# Example 3
#
# Input: @list = (1,1,1,1)
# Output: 6
#
# Good pairs are below:
# (0,1)
# (0,2)
# (0,3)
# (1,2)
# (1,3)
# (2,3)

use Modern::Perl;

sub count_good_pairs {
    my(@in) = @_;
    my $count = 0;
    for my $i (0..$#in-1) {
        for my $j ($i+1..$#in) {
            $count++ if $in[$i] == $in[$j];
        }
    }
    return $count;
}

say count_good_pairs(@ARGV);
