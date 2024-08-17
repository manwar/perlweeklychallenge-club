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

    my $offset = index($str, 'b');
    printf "%s -> %s\n",
        $str,
        ($offset >= 0 and index($str, 'a', $offset) == -1)
            ? 'true'
            : 'false';
}
