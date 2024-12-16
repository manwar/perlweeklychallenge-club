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

from itertools import permutations

def ba(n: int) -> int:
    c = 0
    ints = range(1,n+1,1)
    for p in permutations(ints,n):
        for i in ints:
            if p[i-1] % i != 0 and  i % p[i-1] != 0:
                break
        else:
            c += 1
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
