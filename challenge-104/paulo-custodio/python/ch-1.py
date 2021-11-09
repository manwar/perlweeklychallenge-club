#!/usr/bin/env python3

# Challenge 104
#
# TASK #1 > FUSC Sequence
# Submitted by: Mohammad S Anwar
# Write a script to generate first 50 members of FUSC Sequence. Please refer to
# OEIS for more information.
#
# The sequence defined as below:
#
# fusc(0) = 0
# fusc(1) = 1
# for n > 1:
# when n is even: fusc(n) = fusc(n / 2),
# when n is odd: fusc(n) = fusc((n-1)/2) + fusc((n+1)/2)

import sys

def fusc(num):
    data = [0, 1]
    for n in range(2, num):
        if n%2==0:
            data.append(data[int(n/2)])
        else:
            data.append(data[int((n-1)/2)] + data[int((n+1)/2)])

    return data

print(" ".join([str(x) for x in fusc(int(sys.argv[1]))]))
