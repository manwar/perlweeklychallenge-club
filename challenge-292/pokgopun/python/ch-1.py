### https://theweeklychallenge.org/blog/perl-weekly-challenge-292/
"""

Task 1: Twice Largest

Submitted by: [47]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of integers, @ints, where the largest integer is
   unique.

   Write a script to find whether the largest element in the array is at
   least twice as big as every element in the given array. If it is return
   the index of the largest element or return -1 otherwise.

Example 1

Input: @ints = (2, 4, 1, 0)
Output: 1

The largest integer is 4.
For every other elements in the given array is at least twice as big.
The index value of 4 is 1.

Example 2

Input: @ints = (1, 2, 3, 4)
Output: -1

The largest integer is 4.
4 is less than twice the value of 3, so we return -1.

Task 2: Zuma Game
"""
### solution by pokgopun@gmail.com

def tl(ints: tuple) -> int:
    vi = sorted([(ints[i],i) for i in range(len(ints))])
    if vi[-1][0] >= 2 * vi[-2][0]:
        return vi[-1][1] 
    return -1

import unittest

class TestTl(unittest.TestCase):
    def test(self):
        for inpt, otpt in {
                (2, 4, 1, 0): 1,
                (1, 2, 3, 4): -1,
                }.items():
            self.assertEqual(tl(inpt),otpt)

unittest.main()
