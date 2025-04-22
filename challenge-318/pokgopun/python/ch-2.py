### https://theweeklychallenge.org/blog/perl-weekly-challenge-318/
"""

Task 2: Reverse Equals

Submitted by: [43]Roger Bell_West
     __________________________________________________________________

   You are given two arrays of integers, each containing the same elements
   as the other.

   Write a script to return true if one array can be made to equal the
   other by reversing exactly one contiguous subarray.

Example 1

Input: @source = (3, 2, 1, 4)
       @target = (1, 2, 3, 4)
Output: true

Reverse elements: 0-2

Example 2

Input: @source = (1, 3, 4)
       @target = (4, 1, 3)
Output: false

Example 3

Input: @source = (2)
       @target = (2)
Output: true
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 27th April
   2025.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
"""
### solution by pokgopun@gmail.com

def re(src: tuple[int], dst: tuple[int]) -> bool:
    if src == dst:
        return True
    lst: list[int] = []
    for i in range(len(src)):
        a, b = src[i], dst[i]
        if a != b:
            lst.extend((a, b))
        if len(lst) > 4:
            return False
    return len(lst) == 4 and lst[0] == lst[3] and lst[1] == lst[2]

import unittest

class TestRe(unittest.TestCase):
    def test(self):
        for (src, dst), otpt in {
                ((3, 2, 1, 4),(1, 2, 3, 4)): True,
                ((1, 3, 4),(4, 1, 3)): False,
                ((2,),(2,)): True,
                }.items():
            self.assertEqual(re(src,dst), otpt)

unittest.main()
