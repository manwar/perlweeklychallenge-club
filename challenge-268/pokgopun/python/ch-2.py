### https://theweeklychallenge.org/blog/perl-weekly-challenge-268/
"""

Task 2: Number Game

Submitted by: [48]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of integers, @ints, with even number of
   elements.

   Write a script to create a new array made up of elements of the given
   array. Pick the two smallest integers and add it to new array in
   decreasing order i.e. high to low. Keep doing until the given array is
   empty.

Example 1

Input: @ints = (2, 5, 3, 4)
Output: (3, 2, 5, 4)

Round 1: we picked (2, 3) and push it to the new array (3, 2)
Round 2: we picked the remaining (4, 5) and push it to the new array (5, 4)

Example 2

Input: @ints = (9, 4, 1, 3, 6, 4, 6, 1)
Output: (1, 1, 4, 3, 6, 4, 9, 6)

Example 3

Input: @ints = (1, 2, 2, 3)
Output: (2, 1, 3, 2)
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 12th May 2024.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
"""
### solution by pokgopun@gmail.com

def numberGame(ints: tuple):
    l = len(ints)
    if l==0 or l % 2 != 0:
        return None
    ints = tuple(sorted(ints,reverse=True))
    ans = ()
    while l > 0:
        ans += ints[l-2:l]
        l -= 2
    return ans

import unittest

class TestNumberGame(unittest.TestCase):
    def test(self):
        for inpt, otpt in {
                (2, 5, 3, 4): (3, 2, 5, 4),
                (9, 4, 1, 3, 6, 4, 6, 1): (1, 1, 4, 3, 6, 4, 9, 6),
                (1, 2, 2, 3): (2, 1, 3, 2),
                }.items():
            self.assertEqual(numberGame(inpt),otpt)

unittest.main()
