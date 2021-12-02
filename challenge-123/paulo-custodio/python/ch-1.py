#!/usr/bin/env python

# Challenge 123
#
# TASK #1 > Ugly Numbers
# Submitted by: Mohammad S Anwar
# You are given an integer $n >= 1.
#
# Write a script to find the $nth element of Ugly Numbers.
#
# Ugly numbers are those number whose prime factors are 2, 3 or 5. For example,
# the first 10 Ugly Numbers are 1, 2, 3, 4, 5, 6, 8, 9, 10, 12.
#
# Example
# Input: $n = 7
# Output: 8
#
# Input: $n = 10
# Output: 12

import sys

# return an iterator to generate the sequence
# the sequence is a merge of all multiples of 2, 3 and 5
def hamming_gen():
    seq = [[1], [1], [1]]
    base = [2, 3, 5]

    while True:
        # get the smallest of the multiples
        n = min(seq[0][0], seq[1][0], seq[2][0])

        for i in range(0, 3):
            # shift used multiples
            if seq[i][0] == n:
                seq[i].pop(0)

            # push next multiple
            seq[i].append(n*base[i])

        yield n


# main
iter = hamming_gen()
for i in range(0, int(sys.argv[1])):
    print(next(iter))
