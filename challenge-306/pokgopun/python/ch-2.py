### https://theweeklychallenge.org/blog/perl-weekly-challenge-306/
"""

Task 2: Last Element

Submitted by: [43]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a array of integers, @ints.

   Write a script to play a game where you pick two biggest integers in
   the given array, say x and y. Then do the following:
a) if x == y then remove both from the given array
b) if x != y then remove x and replace y with (y - x)

   At the end of the game, there is at most one element left.

   Return the last element if found otherwise return 0.

Example 1

Input: @ints = (3, 8, 5, 2, 9, 2)
Output: 1

Step 1: pick 8 and 9 => (3, 5, 2, 1, 2)
Step 2: pick 3 and 5 => (2, 2, 1, 2)
Step 3: pick 2 and 1 => (1, 2, 2)
Step 4: pick 2 and 1 => (1, 2)
Step 5: pick 1 and 2 => (1)

Example 2

Input: @ints = (3, 2, 5)
Output: 0

Step 1: pick 3 and 5 => (2, 2)
Step 2: pick 2 and 2 => ()
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 2^nd January
   2025.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
"""
### solution by pokgopun@gmail.com

from typing import Tuple

def lstelm(ints: Tuple[int]) -> int:
    lst = list(ints)
    while True:
        l = len(lst)
        match l:
            case 0:
                return 0
            case 1:
                return lst[0]
            case 2:
                pass
            case _:
                lst.sort()
        d = lst[-2] - lst[-1]
        if d == 0:
            lst = lst[:-2]
            continue
        if d < 0:
            d *= -1
        lst[-2] = d
        lst = lst[:-1]

import unittest

class TestLstelm(unittest.TestCase):
    def test(self):
        for inpt, otpt in {
                (3, 8, 5, 2, 9, 2): 1,
                (3, 2, 5): 0,
                }.items():
            self.assertEqual(lstelm(inpt), otpt)

unittest.main()
