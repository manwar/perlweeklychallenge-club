#!/usr/bin/python3

# Challenge 079
#
# TASK #1 > Count Set Bits
# Submitted by: Mohammad S Anwar
# You are given a positive number $N.
#
# Write a script to count the total numbrer of set bits of the binary
# representations of all numbers from 1 to $N and return
# $total_count_set_bit % 1000000007.
#
# Example 1:
# Input: $N = 4
#
# Explanation: First find out the set bit counts of all numbers i.e. 1, 2, 3
# and 4.
#
#     Decimal: 1
#     Binary: 001
#     Set Bit Counts: 1
#
#     Decimal: 2
#     Binary: 010
#     Set Bit Counts: 1
#
#     Decimal: 3
#     Binary: 011
#     Set Bit Counts: 2
#
#     Decimal: 4
#     Binary: 100
#     Set Bit Counts: 1
#
#     Total set bit count: 1 + 1 + 2 + 1 = 5
#
# Output: Your script should print `5` as `5 % 1000000007 = 5`.
# Example 2:
# Input: $N = 3
#
# Explanation: First find out the set bit counts of all numbers i.e. 1, 2 and 3.
#
#     Decimal: 1
#     Binary: 01
#     Set Bit Count: 1
#
#     Decimal: 2
#     Binary: 10
#     Set Bit Count: 1
#
#     Decimal: 3
#     Binary: 11
#     Set Bit Count: 2
#
#     Total set bit count: 1 + 1 + 2 = 4
#
# Output: Your script should print `4` as `4 % 1000000007 = 4`.

import sys

def bit_count(n):
    bits = "{:b}".format(n)
    return sum([int(x) for x in bits])

print(sum([bit_count(x) for x in range(1, int(sys.argv[1])+1)]) % 1000000007)
