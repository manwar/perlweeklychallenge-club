### https://theweeklychallenge.org/blog/perl-weekly-challenge-286/
"""

Task 2: Order Game

Submitted by: [57]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of integers, @ints, whose length is a power of
   2.

   Write a script to play the order game (min and max) and return the last
   element.

Example 1

Input: @ints = (2, 1, 4, 5, 6, 3, 0, 2)
Output: 1

Operation 1:

    min(2, 1) = 1
    max(4, 5) = 5
    min(6, 3) = 3
    max(0, 2) = 2

Operation 2:

    min(1, 5) = 1
    max(3, 2) = 3

Operation 3:

    min(1, 3) = 1

Example 2

Input: @ints = (0, 5, 3, 2)
Output: 0

Operation 1:

    min(0, 5) = 0
    max(3, 2) = 3

Operation 2:

    min(0, 3) = 0

Example 3

Input: @ints = (9, 2, 1, 4, 5, 6, 0, 7, 3, 1, 3, 5, 7, 9, 0, 8)
Output: 2

Operation 1:

    min(9, 2) = 2
    max(1, 4) = 4
    min(5, 6) = 5
    max(0, 7) = 7
    min(3, 1) = 1
    max(3, 5) = 5
    min(7, 9) = 7
    max(0, 8) = 8

Operation 2:

    min(2, 4) = 2
    max(5, 7) = 7
    min(1, 5) = 1
    max(7, 8) = 8

Operation 3:

    min(2, 7) = 2
    max(1, 8) = 8

Operation 4:

    min(2, 8) = 2
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 15th September
   2024.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
"""
### solution by pokgopun@gmail.com

from itertools import pairwise

def og(ints: tuple):
    while len(ints) > 2:
        ints = tuple(e for e in pairwise(ints))
        ints = tuple(max(ints[i]) if i % 2 else min(ints[i]) for i in range(len(ints)))
    return min(ints) 

import unittest

class TestOg(unittest.TestCase):
    def test(self):
        for inpt,otpt in {
                (2, 1, 4, 5, 6, 3, 0, 2): 1,
                (0, 5, 3, 2): 0,
                (9, 2, 1, 4, 5, 6, 0, 7, 3, 1, 3, 5, 7, 9, 0, 8): 2,
                }.items():
            self.assertEqual(og(inpt),otpt)

unittest.main()
