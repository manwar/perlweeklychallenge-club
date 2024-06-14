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

def out(str):
    offset = str.find('b')
    if offset >= 0 and str.find('a', offset) == -1:
        res = "true"
    else:
        res = "false"
    print("%s -> %s" % 
             ( str, res )
    )

if __name__ == "__main__":
    str = "aabb"
    out(str)

    str = "abab"
    out(str)

    str = "aaa"
    out(str)

    str = "bbb"
    out(str)
