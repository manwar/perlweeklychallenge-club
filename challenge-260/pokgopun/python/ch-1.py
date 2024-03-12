### https://theweeklychallenge.org/blog/perl-weekly-challenge-260/
"""

Task 1: Unique Occurrences

Submitted by: [42]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of integers, @ints.

   Write a script to return 1 if the number of occurrences of each value
   in the given array is unique or 0 otherwise.

Example 1

Input: @ints = (1,2,2,1,1,3)
Output: 1

The number 1 occurred 3 times.
The number 2 occurred 2 times.
The number 3 occurred 1 time.

All occurrences are unique, therefore the output is 1.

Example 2

Input: @ints = (1,2,3)
Output: 0

Example 3

Input: @ints = (-2,0,1,-2,1,1,0,1,-2,9)
Output: 1

Task 2: Dictionary Rank
"""
### solution by pokgopun@gmail.com

def UO(tup: tuple):
    s = set(tup)
    return len(s)==len(set(tup.count(e) for e in s))

import unittest

class TestUO(unittest.TestCase):
    def test(self):
        for inpt, otpt in {
                (1,2,2,1,1,3): 1,
                (1,2,3): 0,
                (-2,0,1,-2,1,1,0,1,-2,9): 1,
                }.items():
            self.assertEqual(UO(inpt),otpt)

unittest.main()


