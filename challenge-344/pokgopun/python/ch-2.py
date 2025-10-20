### https://theweeklychallenge.org/blog/perl-weekly-challenge-344/
"""

Task 2: Array Formation

Submitted by: [44]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given two list: @source and @target.

   Write a script to see if you can build the exact @target by putting
   these smaller lists from @source together in some order. You cannot
   break apart or change the order inside any of the smaller lists in
   @source.

Example 1

Input: @source = ([2,3], [1], [4])
       @target = (1, 2, 3, 4)
Output: true

Use in the order: [1], [2,3], [4]

Example 2

Input: @source = ([1,3], [2,4])
       @target = (1, 2, 3, 4)
Output: false

Example 3

Input: @source = ([9,1], [5,8], [2])
       @target = (5, 8, 2, 9, 1)
Output: true

Use in the order: [5,8], [2], [9,1]

Example 4

Input: @source = ([1], [3])
       @target = (1, 2, 3)
Output: false

Missing number: 2

Example 5

Input: @source = ([7,4,6])
       @target = (7, 4, 6)
Output: true

Use in the order: [7, 4, 6]
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 26th October
   2025.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
"""
### solution by pokgopun@gmail.com

from itertools import permutations, chain

def af(source: tuple[tuple[int]], target: tuple[int]) -> bool:
    for pmt in permutations(source, len(source)):
        #print(f'pmt => {pmt}')
        if target == tuple(chain.from_iterable(pmt)):
            return True
    return False

import unittest

class TestAf(unittest.TestCase):
    def test(self):
        for (source, target), otpt in {
            (((2,3), (1,), (4,)), (1, 2, 3, 4)): True,
            (((1,3), (2,4)), (1, 2, 3, 4)): False,
            (((9,1), (5,8), (2,)), (5, 8, 2, 9, 1)): True,
            (((1,), (3,)), (1, 2, 3)): False,
            (((7,4,6),), (7, 4, 6)): True,
            }.items():
            self.assertEqual(af(source,target),otpt)

unittest.main()
