#!/usr/bin/env python3
#
#
#       chowla.py
#
#       TASK #1 › Chowla Numbers
#         Submitted by: Mohammad S Anwar
#         Write a script to generate first 20 Chowla Numbers, named after, Sarvadaman D. S. Chowla, a London born Indian American mathematician. It is defined as:
# 
#         C(n) = sum of divisors of n except 1 and n
#
#         Output:
#         0, 0, 0, 2, 0, 5, 0, 6, 3, 7, 0, 15, 0, 9, 8, 14, 0, 20, 0, 21
#
#
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##

import math

def sum_divisors (n):
    out = 0
    for d in range( 2, int(math.sqrt(n))+1 ):
        id = divmod(n,d)
        if id[1] == 0:
            out += d 
            if id[0] != d:
                out += id[0]
    return out


for n in range(1,21):
    print(f"C({n}) = ", sum_divisors(n))


