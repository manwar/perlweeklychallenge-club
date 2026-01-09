#!/usr/bin/env perl

# Challenge 355
#
# Task 2: Mountain Array
# Submitted by: Mohammad Sajid Anwar
# You are given an array of integers, @ints.
#
# Write a script to return true if the given array is a valid mountain array.
#
# An array is mountain if and only if:
# 1) arr.length >= 3
# and
# 2) There exists some i with 0 < i < arr.length - 1 such that:
# arr[0] < arr[1]     < ... < arr[i - 1] < arr[i]
# arr[i] > arr[i + 1] > ... > arr[arr.length - 1]
# Example 1
# Input: @ints = (1, 2, 3, 4, 5)
# Output: false
#
# Example 2
# Input: @ints = (0, 2, 4, 6, 4, 2, 0)
# Output: true
#
# Example 3
# Input: @ints = (5, 4, 3, 2, 1)
# Output: false
#
# Example 4
# Input: @ints = (1, 3, 5, 5, 4, 2)
# Output: false
#
# Example 5
# Input: @ints = (1, 3, 2)
# Output: true

use Modern::Perl;

@ARGV or die "Usage: $0 nums...\n";

say is_mountain(@ARGV) ? "true" : "false";

sub is_mountain {
    my(@nums) = @_;
    return 0 if @nums < 3;
    my $last = shift(@nums);
    return 0 if $nums[0] <= $last;
    my $climbing = 1;
    while (@nums) {
        if ($climbing && $nums[0] > $last) {    # climb
            $last = shift @nums;
        }
        elsif ($climbing && $nums[0] < $last) { # descend
            $climbing = 0;
            $last = shift @nums;
        }
        elsif ($climbing) {                     # flat
            return 0;
        }
        elsif (!$climbing && $nums[0] < $last) {# descend
            $last = shift @nums;
        }
        else {
            return 0;                           # clim or flat
        }
    }
    return !$climbing;
}
