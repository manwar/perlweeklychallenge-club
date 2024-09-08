#!/usr/bin/env python3

# Challenge 054
#
# TASK #2
# Collatz Conjecture
# Contributed by Ryan Thompson
# It is thought that the following sequence will always reach 1:
#
# $n = $n / 2 when $n is even
# $n = 3*$n + 1 when $n is odd
# For example, if we start at 23, we get the following sequence:
#
# 23 -> 70 -> 35 -> 106 -> 53 -> 160 -> 80 -> 40 -> 20 -> 10 -> 5 -> 16 -> 8
# -> 4 -> 2 -> 1
#
# Write a function that finds the Collatz sequence for any positive integer.
# Notice how the sequence itself may go far above the original starting number.
#
# Extra Credit
# Have your script calculate the sequence length for all starting numbers up to
# 1000000 (1e6), and output the starting number and sequence length for the
# longest 20 sequences.

import sys

def collatz_seq(n):
    out = [n]
    while n != 1:
        if n % 2 == 0:
            n = int(n/2)
        else:
            n = 3*n + 1
        out.append(n)
    return out

def print_longest():
    longest = []
    for n in range(1, int(1e6)+1):
        count = len(collatz_seq(n))
        longest.append([n, count])
        longest.sort(key=lambda x:x[0])
        longest = longest[::-1]
        longest.sort(key=lambda x:x[1])
        longest = longest[::-1]
        if len(longest) > 20:
            longest.pop()

    for i in longest:
        print(str(i[0])+" "+str(i[1]))


if sys.argv[1] == "-l":
    print_longest()
else:
    n = int(sys.argv[1])
    seq = collatz_seq(n)
    print(" -> ".join([str(x) for x in seq]))
