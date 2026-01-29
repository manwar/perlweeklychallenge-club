#!/usr/bin/env perl

# Challenge 314
#
# Task 1: Equal Strings
# Submitted by: Mohammad Sajid Anwar
# You are given three strings.
#
# You are allowed to remove the rightmost character of a string to make all equals.
#
# Write a script to return the number of operations to make it equal otherwise -1.
#
# Example 1
# Input: $s1 = "abc", $s2 = "abb", $s3 = "ab"
# Output: 2
#
# Operation 1: Delete "c" from the string "abc"
# Operation 2: Delete "b" from the string "abb"
# Example 2
# Input: $s1 = "ayz", $s2 = "cyz", $s3 = "xyz"
# Output: -1
# Example 3
# Input: $s1 = "yza", $s2 = "yzb", $s3 = "yzc"
# Output: 3

use Modern::Perl;

@ARGV or die "usage: $0 strs...\n";
say num_ops(@ARGV);

sub num_ops {
    my(@strs) = @_;
    my $prefix = common_prefix(@strs);
    if ($prefix eq '') {
        return -1;
    }
    else {
        my $ops = 0;
        for (@strs) {
            $ops += length($_) - length($prefix);
        }
        return $ops;
    }
}

sub common_prefix {
    my(@strs) = @_;
    my $prefix = "";
    for my $i (0 .. length($strs[0]) - 1) {
        for (@strs) {
            if (substr($_, $i, 1) ne substr($strs[0], $i, 1)) {
                return $prefix;
            }
        }
        $prefix .= substr($strs[0], $i, 1);
    }
    return $prefix;
}
