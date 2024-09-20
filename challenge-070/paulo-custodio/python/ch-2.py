#!/usr/bin/env perl

# Challenge 070
#
# TASK #2 > Gray Code Sequence
# Submitted by: Mohammad S Anwar
# You are given an integer 2 <= $N <= 5.
#
# Write a script to generate $N-bit gray code sequence.
#
# 2-bit Gray Code Sequence
# [0, 1, 3, 2]
# To generate the 3-bit Gray code sequence from the 2-bit Gray code sequence,
# follow the step below:
#
# 2-bit Gray Code sequence
# [0, 1, 3, 2]
#
# Binary form of the sequence
# a) S1 = [00, 01, 11, 10]
#
# Reverse of S1
# b) S2 = [10, 11, 01, 00]
#
# Prefix all entries of S1 with '0'
# c) S1 = [000, 001, 011, 010]
#
# Prefix all entries of S2 with '1'
# d) S2 = [110, 111, 101, 100]
#
# Concatenate S1 and S2 gives 3-bit Gray Code sequence
# e) [000, 001, 011, 010, 110, 111, 101, 100]
#
# 3-bit Gray Code sequence
# [0, 1, 3, 2, 6, 7, 5, 4]
# Example
# Input: $N = 4
#
# Output: [0, 1, 3, 2, 6, 7, 5, 4, 12, 13, 15, 14, 10, 11, 9, 8]

import sys

def gray(n):
    if n < 2:
        raise ValueError("N must be at least 2")
    elif n == 2:
        return [0, 1, 3, 2]
    else:
        # gray sequence of N-1
        prev = gray(n-1)
        # binary form to S1
        s1 = [format(x, f'0{n-1}b') for x in prev]
        # reverse to S2
        s2 = s1[::-1]
        # prefix S1 with 0
        s1 = ['0' + x for x in s1]
        # prefix S2 with 1
        s2 = ['1' + x for x in s2]
        # concatenate
        gray_seq = s1 + s2
        # convert to decimal
        gray_seq = [int(x, 2) for x in gray_seq]

        return gray_seq

if __name__ == "__main__":
    N = int(sys.argv[1]) if len(sys.argv) > 1 else 2
    print(", ".join(map(str, gray(N))))
