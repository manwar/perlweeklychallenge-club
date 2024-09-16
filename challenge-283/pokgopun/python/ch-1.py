### https://theweeklychallenge.org/blog/perl-weekly-challenge-283/
"""

Task 1: Unique Number

Submitted by: [45]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of integers, @ints, where every elements appears
   more than once except one element.

   Write a script to find the one element that appears exactly one time.

Example 1

Input: @ints = (3, 3, 1)
Output: 1

Example 2

Input: @ints = (3, 2, 4, 2, 4)
Output: 3

Example 3

Input: @ints = (1)
Output: 1

Example 4

Input: @ints = (4, 3, 1, 1, 1, 4)
Output: 3

Task 2: Digit Count Value
"""
### solution by pokgopun@gmail.com

def uniqNum(ints):
    return sorted(
            (ints.count(e),e) for e in ints
            )[0][1]

import unittest

class TestUniqNum(unittest.TestCase):
    def test(self):
        for inpt,otpt in {
                (3, 3, 1): 1,
                (3, 2, 4, 2, 4): 3,
                (1,): 1,
                (4, 3, 1, 1, 1, 4): 3,
                }.items():
            self.assertEqual(uniqNum(inpt),otpt)

unittest.main()
