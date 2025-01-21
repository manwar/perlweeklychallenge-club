### https://theweeklychallenge.org/blog/perl-weekly-challenge-305/
"""

Task 1: Binary Prefix

Submitted by: [40]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a binary array.

   Write a script to return an array of booleans where the partial binary
   number up to that point is prime.

Example 1

Input: @binary = (1, 0, 1)
Output: (false, true, true)

Sub-arrays (base-10):
(1): 1 - not prime
(1, 0): 2 - prime
(1, 0, 1): 5 - prime

Example 2

Input: @binary = (1, 1, 0)
Output: (false, true, false)

Sub-arrays (base-10):
(1): 1 - not prime
(1, 1): 3 - prime
(1, 1, 0): 6 - not prime

Example 3

Input: @binary = (1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 1)
Output: (false, true, true, false, false, true, false, false, false, false, fals
e, false, false, false, false, false, false, false, false, true)

Task 2: Alien Dictionary
"""
### solution by pokgopun@gmail.com

from typing import Tuple
from sympy import isprime

def bp(binary: Tuple[int]) -> Tuple[bool]:
    c = binary[0]
    lst: List[bool] = [isprime(c)]
    for b in binary[1:]:
        c = c*2 + b
        lst.append(isprime(c))
    return tuple(lst)

import unittest

class TestBp(unittest.TestCase):
    def test(self):
        for inpt, otpt in {
                (1, 0, 1): (False, True, True),
                (1, 1, 0): (False, True, False),
                (1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 1): (False, True, True, False, False, True, False, False, False, False, False, False, False, False, False, False, False, False, False, True),
                }.items():
            self.assertEqual(bp(inpt),otpt)

unittest.main()
