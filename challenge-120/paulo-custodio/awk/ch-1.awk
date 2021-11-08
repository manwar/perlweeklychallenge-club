#!/usr/bin/env gawk

# Challenge 120
#
# TASK #1 - Swap Odd/Even bits
# Submitted by: Mohammad S Anwar
# You are given a positive integer $N less than or equal to 255.
#
# Write a script to swap the odd positioned bit with even positioned bit and
# print the decimal equivalent of the new binary representation.
#
# Example
# Input: $N = 101
# Output: 154
#
# Binary representation of the given number is 01 10 01 01.
# The new binary representation after the odd/even swap is 10 01 10 10.
# The decimal equivalent of 10011010 is 154.
#
# Input: $N = 18
# Output: 33
#
# Binary representation of the given number is 00 01 00 10.
# The new binary representation after the odd/even swap is 00 10 00 01.
# The decimal equivalent of 100001 is 33.

function swap_bits(n,  out, bits) {
    out = 0
    bits = 0
    while (n > 0) {
        if (and(n, 1) != 0) { out = or(out, lshift(2, bits)) }
        if (and(n, 2) != 0) { out = or(out, lshift(1, bits)) }
        n = rshift(n, 2)
        bits = bits + 2;
    }
    return out
}

BEGIN {
    n = ARGV[1]
    n = swap_bits(n)
    print n
    exit
}
