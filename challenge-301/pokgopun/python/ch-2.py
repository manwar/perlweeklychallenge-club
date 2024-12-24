### https://theweeklychallenge.org/blog/perl-weekly-challenge-301/
"""

Task 2: Hamming Distance

Submitted by: [72]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of integers, @ints.

   Write a script to return the sum of Hamming distances between all the
   pairs of the integers in the given array of integers.
The Hamming distance between two integers is the number of places in which their
 binary representations differ.

Example 1

Input: @ints = (4, 14, 2)
Output: 6

Binary representation:
4  => 0100
14 => 1110
2  => 0010

HammingDistance(4, 14) + HammingDistance(4, 2) + HammingDistance(14, 2) = 2 + 2
+ 2 = 6.

Example 2

Input: @ints = (4, 14, 4)
Output: 4
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 29^th December
   2024.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
"""
### solution by pokgopun@gmail.com

from typing import Tuple
from itertools import combinations

def hd(ints: Tuple[int]) -> int:
    c = 0
    for p in combinations(ints,2):
        b1 = bin(p[0])[2:]
        b2 = bin(p[1])[2:]
        l1 = len(b1)
        l2 = len(b2)
        l = l1 - l2
        if l < 0:
            b1 = '0' * -l + b1
        elif l > 0:
            b2 = '0' * l + b2
        for i in range(max(l1,l2)):
            if b1[i] != b2[i]:
                c += 1
    return c

import unittest

class TestHd(unittest.TestCase):
    def test(self):
        for inpt, otpt in {
                (4, 14, 2): 6,
                (4, 14, 4): 4,
                }.items():
            self.assertEqual(hd(inpt),otpt)

unittest.main()
