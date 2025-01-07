### https://theweeklychallenge.org/blog/perl-weekly-challenge-303/
"""

Task 1: 3-digits Even

Submitted by: [39]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a list (3 or more) of positive integers, @ints.

   Write a script to return all even 3-digits integers that can be formed
   using the integers in the given list.

Example 1

Input: @ints = (2, 1, 3, 0)
Output: (102, 120, 130, 132, 210, 230, 302, 310, 312, 320)

Example 2

Input: @ints = (2, 2, 8, 8, 2)
Output: (222, 228, 282, 288, 822, 828, 882)

Task 2: Delete and Earn
"""
### solution by pokgopun@gmail.com

from typing import Tuple
from itertools import permutations

def tde(ints: Tuple[int]) -> Tuple[int]:
    return tuple(
            sorted(
                set(
                    int("".join(str(d) for d in e)) for e in
                    (p for p in permutations(ints,3) if p[0] != 0 and p[-1] % 2 == 0)
                    )
                )
            )

import unittest

class Test3de(unittest.TestCase):
    def test(self):
        for inpt, otpt in {
                (2, 1, 3, 0): (102, 120, 130, 132, 210, 230, 302, 310, 312, 320),
                (2, 2, 8, 8, 2): (222, 228, 282, 288, 822, 828, 882),
                }.items():
            self.assertEqual(tde(inpt), otpt)

unittest.main()
