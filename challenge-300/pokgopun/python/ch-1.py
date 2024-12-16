### https://theweeklychallenge.org/blog/perl-weekly-challenge-300/
"""

Task 1: Beautiful Arrangement

Submitted by: [54]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a positive integer, $int.

   Write a script to return the number of beautiful arrangements that you
   can construct.
A permutation of n integers, 1-indexed, is considered a beautiful arrangement
if for every i (1 <= i <= n) either of the following is true:

1) perm[i] is divisible by i
2) i is divisible by perm[i]

Example 1

Input: $n = 2
Output: 2

1st arrangement: [1, 2]
    perm[1] is divisible by i = 1
    perm[2] is divisible by i = 2
2nd arrangement: [2, 1]
    perm[1] is divisible by i = 1
    i=2 is divisible by perm[2] = 1

Example 2

Input: $n = 1
Output: 1

Example 3

Input: $n = 10
Output: 700

Task 2: Nested Array
"""
### solution by pokgopun@gmail.com

from typing import List,Tuple

class Processor:
    def __init__(self, s:List[int], p:List[int]):
        self.s = s
        self.p = p
        #print(self.s, self.p)
    def __repr__(self):
        return f'({self.s},{self.p}'

def ba(n: int) -> int:
    rng = range(n)
    return bpermute(Processor([i+1 for i in rng], [0 for i in rng]))

def bpermute(p: Processor) -> int:
    l = len(p.s)
    if l == 0:
        #print("=>",p.p)
        return 1
    c = 0
    idx = len(p.p) - l + 1
    for i in range(l):
        if idx % p.s[i] != 0 and p.s[i] % idx != 0:
            continue
        p.p[idx-1] = p.s[i]
        c += bpermute(Processor(p.s[:i] + p.s[i+1:],p.p))
    return c

import unittest

class TestBa(unittest.TestCase):
    def test(self):
        for inpt, otpt in {
                2: 2,
                1: 1,
                10: 700,
                }.items():
            self.assertEqual(ba(inpt), otpt)

unittest.main()
