#!/usr/bin/env python3

# Challenge 055
#
# TASK #1
# Flip Binary
# You are given a binary number B, consisting of N binary digits 0 or 1: s0, s1,
# …, s(N-1).
#
# Choose two indices L and R such that 0 = L = R < N and flip the digits s(L),
# s(L+1), …, s(R). By flipping, we mean change 0 to 1 and vice-versa.
#
# For example, given the binary number 010, the possible flip pair results are
# listed below:
#
# L=0, R=0 the result binary: 110
# L=0, R=1 the result binary: 100
# L=0, R=2 the result binary: 101
# L=1, R=1 the result binary: 000
# L=1, R=2 the result binary: 001
# L=2, R=2 the result binary: 011
# Write a script to find the indices (L,R) that results in a binary number with
# maximum number of 1s. If you find more than one maximal pair L,R then print
# all of them.
#
# Continuing our example, note that we had three pairs (L=0, R=0), (L=0, R=2),
# and (L=2, R=2) that resulted in a binary number with two 1s, which was the
# maximum. So we would print all three pairs.

import sys

bin = sys.argv[1]
max_1s = 0
max_1s_pairs = []

for l in range(0, len(bin)-1+1):
    for r in range(l, len(bin)-1+1):
        bits = [int(x) for x in bin]
        for i in range(l, r+1):
            bits[i] = 1-bits[i]
        _1s = len(list(filter(lambda x:x==1, bits)))
        if _1s > max_1s:
            max_1s = _1s
            max_1s_pairs = [[l,r]]
        elif _1s == max_1s:
            max_1s_pairs.append([l,r])

out = []
for x in max_1s_pairs:
    out.append("(L="+str(x[0])+", R="+str(x[1])+")")
print(", ".join(out))
