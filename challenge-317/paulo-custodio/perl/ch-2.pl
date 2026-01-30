#!/usr/bin/env perl

# Challenge 317
#
# Task 2: Friendly Strings
# Submitted by: Mohammad Sajid Anwar
# You are given two strings.
#
# Write a script to return true if swapping any two letters in one string match the other string, return false otherwise.
#
#
# Example 1
# Input: $str1 = "desc", $str2 = "dsec"
# Output: true
#
# Example 2
# Input: $str1 = "fuck", $str2 = "fcuk"
# Output: true
#
# Example 3
# Input: $str1 = "poo", $str2 = "eop"
# Output: false
#
# Example 4
# Input: $str1 = "stripe", $str2 = "sprite"
# Output: true

use Modern::Perl;

@ARGV==2 or die "usage: $0 str1 str2\n";
say is_friendly(@ARGV) ? "true" : "false";

sub is_friendly {
    my($str1, $str2) = @_;
    for my $i (0 .. length($str1)-2) {
        for my $j ($i+1 .. length($str1)-1) {
            my $cmp1 = substr($str1, 0, $i).
                       substr($str1, $j, 1).
                       substr($str1, $i+1, $j-$i-1).
                       substr($str1, $i, 1).
                       substr($str1, $j+1);
            return 1 if $cmp1 eq $str2;
        }
    }
    return 0;
}
