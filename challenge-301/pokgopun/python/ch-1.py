### https://theweeklychallenge.org/blog/perl-weekly-challenge-301/
"""

Task 1: Largest Number

Submitted by: [71]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a list of positive integers, @ints.

   Write a script to arrange all the elements in the given list such that
   they form the largest number and return it.

Example 1

Input: @ints = (20, 3)
Output: 320

Example 2

Input: @ints = (3, 30, 34, 5, 9)
Output: 9534330

Task 2: Hamming Distance
"""
### solution by pokgopun@gmail.com

from typing import Tuple
from functools import cmp_to_key

def dcmp(a: int, b: int) -> int:
    a = str(a)
    b = str(b)
    la = len(a)
    lb = len(b)
    if la == lb:
        if a == b:
            return 0
        if a < b:
            return -1
        else:
            return 1
    l = max(la, lb)
    a = tuple(int(e) for e in a)
    b = tuple(int(e) for e in b)
    for i in range(l):
        try:
            if a[i] == b[i]:
                continue
            else:
                return a - b
        except:
            if la < lb:
                if a[-1] == b[i]:
                    continue
                else:
                    return a[-1] - b[i]
            else:
                if a[i] == b[-1]:
                    continue
                else:
                    return a[i] - b[-1]

def ln(ints: Tuple[int]) -> int:
    ints = list(ints)
    ints = sorted(ints, key=cmp_to_key(dcmp),reverse=True)
    return int("".join((str(e) for e in ints)))

import unittest

class TestLn(unittest.TestCase):
    def test(self):
        for inpt, otpt in {
                (20, 3): 320,
                (3, 30, 34, 5, 9): 9534330,
                (4, 43, 445, 5, 8, 9): 985445443,
                }.items():
            self.assertEqual(ln(inpt),otpt)

unittest.main()
