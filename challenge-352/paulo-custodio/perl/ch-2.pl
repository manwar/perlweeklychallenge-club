#!/usr/bin/env perl

# Challenge 352
#
# Task 2: Binary Prefix
# Submitted by: Mohammad Sajid Anwar
# You are given an array, @nums, where each element is either 0 or 1.
#
# Define xi as the number formed by taking the first i+1 bits of @nums (from $nums[0] to $nums[i]) and interpreting them as a binary number, with $nums[0] being the most significant bit.
#
# For example:
#
# If @nums = (1, 0, 1), then:
#
# x0 = 1 (binary 1)
# x1 = 2 (binary 10)
# x2 = 5 (binary 101)
#
# For each i, check whether xi is divisible by 5.
# Write a script to return an array @answer where $answer[i] is true if x<sub>i</sub> is divisible by 5, otherwise false.
#
# Example 1
# Input: @nums = (0,1,1,0,0,1,0,1,1,1)
# Output: (true, false, false, false, false, true, true, false, false, false)
#
# Binary numbers formed (decimal values):
#          0: 0
#         01: 1
#        011: 3
#       0110: 6
#      01100: 12
#     011001: 25
#    0110010: 50
#   01100101: 101
#  011001011: 203
# 0110010111: 407
#
# Example 2
# Input: @num = (1,0,1,0,1,0)
# Output: (false, false, true, true, false, false)
#
#      1: 1
#     10: 2
#    101: 5
#   1010: 10
#  10101: 21
# 101010: 42
#
# Example 3
# Input: @num = (0,0,1,0,1)
# Output: (true, true, false, false, true)
#
#     0: 0
#    00: 0
#   001: 1
#  0010: 2
# 00101: 5
#
# Example 4
# Input: @num = (1,1,1,1,1)
# Output: (false, false, false, true, false)
#
#     1: 1
#    11: 3
#   111: 7
#  1111: 15
# 11111: 31
#
# Example 5
# Input: @num = (1,0,1,1,0,1,0,0,1,1)
# Output: (false, false, true, false, false, true, true, true, false, false)
#
#          1: 1
#         10: 2
#        101: 5
#       1011: 11
#      10110: 22
#     101101: 45
#    1011010: 90
#   10110100: 180
#  101101001: 361
# 1011010011: 723

use Modern::Perl;

@ARGV or die "usage: $0 1 0 1 0...\n";

my @result = map {$_ ? 'true' : 'false'}
             map {$_ % 5 == 0} prefix_bin(@ARGV);
say join ", ", @result;

sub prefix_bin {
    my(@digits) = @_;
    my @values;
    for my $i (0 .. $#digits) {
        my $str = "0b".join("", @digits[0..$i]);
        my $value = eval($str);
        $@ and dir $@;
        push @values, $value;
    }
    return @values;
}
