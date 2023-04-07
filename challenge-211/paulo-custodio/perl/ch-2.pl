#!/usr/bin/perl

# Challenge 211
#
# Task 2: Split Same Average
# Submitted by: Mohammad S Anwar
#
# You are given an array of integers.
#
# Write a script to find out if the given can be split into two separate arrays
# whose average are the same.
# Example 1:
#
# Input: @nums = (1, 2, 3, 4, 5, 6, 7, 8)
# Output: true
#
# We can split the given array into (1, 4, 5, 8) and (2, 3, 6, 7).
# The average of the two arrays are the same i.e. 4.5.
#
# Example 2:
#
# Input: @list = (1, 3)
# Output: false

use Modern::Perl;
use List::Util 'sum';

sub split_same_avg_ {
    my($found, $a, $b, @pending) = @_;
    if ($$found) {
    }
    elsif (!@pending) {
        my @a = @$a;
        my @b = @$b;
        if (@a && @b && abs(sum(@a)/@a - sum(@b)/@b) < 1e-6) {
            $$found = 1;
        }
    }
    else {
        split_same_avg_($found, [@$a, $pending[0]], $b, @pending[1..$#pending]);
        split_same_avg_($found, $a, [@$b, $pending[0]], @pending[1..$#pending]);
    }
}

sub split_same_avg {
    my(@nums) = @_;
    my $found = 0;
    split_same_avg_(\$found, [], [], @nums);
    return $found;
}

@ARGV or die "usage: ch-2.pl nums...\n";
say split_same_avg(@ARGV);
