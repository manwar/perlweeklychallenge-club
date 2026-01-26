#!/usr/bin/env perl

# Challenge 304
#
# Task 1: Arrange Binary
# Submitted by: Mohammad Sajid Anwar
# You are given a list of binary digits (0 and 1) and a positive integer, $n.
#
# Write a script to return true if you can re-arrange the list by replacing at least $n digits with 1 in the given list so that no two consecutive digits are 1 otherwise return false.
#
# Example 1
# Input: @digits = (1, 0, 0, 0, 1), $n = 1
# Output: true
#
# Re-arranged list: (1, 0, 1, 0, 1)
# Example 2
# Input: @digits = (1, 0, 0, 0, 1), $n = 2
# Output: false

use Modern::Perl;

@ARGV==2 or die "usage: $0 1010101 n\n";

say can_arrange(@ARGV) ? "true" : "false";

sub can_arrange {
    my($bin, $n) = @_;
    return 0 if $bin =~ /11/;
    # replace minimum of n digits
    for (1..$n) {
        return 0 if !($bin =~ s/000/010/);
    }
    return 1;
}


