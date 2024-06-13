#!/usr/bin/env perl

# Task 2: B After A
# Submitted by: Mohammad Sajid Anwar
# 
# You are given a string, $str.
# Write a script to return true if there is at least one b, and no a appears after the first b.
# 
# Example 1
# Input: $str = "aabb"
# Output: true
# 
# Example 2
# Input: $str = "abab"
# Output: false
# 
# Example 3
# Input: $str = "aaa"
# Output: false
# 
# Example 4
# Input: $str = "bbb"
# Output: true

use strict;
use warnings;

my $str = "aabb";
position($str);

$str = "abab";
position($str);

$str = "aaa";
position($str);

$str = "bbb";
position($str);

exit 0;

sub position {
    my $str = shift;

    my $first_b = index($str, 'b');
    my $last_a = index((scalar reverse $str), 'a');
    $last_a = length($str) - $last_a - 1
        if $last_a >= 0;

    printf "%s -> %s\n",
        $str,
        ($last_a > $first_b)
            ? 'false'
            : 'true';
}
