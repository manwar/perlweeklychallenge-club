### https://theweeklychallenge.org/blog/perl-weekly-challenge-351/
"""

Task 2: Arithmetic Progression

Submitted by: [56]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of numbers.

   Write a script to return true if the given array can be re-arranged to
   form an arithmetic progression, otherwise return false.

     A sequence of numbers is called an arithmetic progression if the
     difference between any two consecutive elements is the same.

Example 1

Input: @num = (1, 3, 5, 7, 9)
Output: true

Already AP with common difference 2.

Example 2

Input: @num = (9, 1, 7, 5, 3)
Output: true

The given array re-arranged like (1, 3, 5, 7, 9) with common difference 2.

Example 3

Input: @num = (1, 2, 4, 8, 16)
Output: false

This is geometric progression and not arithmetic progression.

Example 4

Input: @num = (5, -1, 3, 1, -3)
Output: true

The given array re-arranged like (-3, -1, 1, 3, 5) with common difference 2.

Example 5

Input: @num = (1.5, 3, 0, 4.5, 6)
Output: true

The given array re-arranged like (0, 1.5, 3, 4.5, 6) with common difference 1.5.
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 14th December
   2025.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
"""
### solution by pokgopun@gmail.com

def ap(num: list[float]) -> bool:
    l = len(num) - 1
    if l < 2:
        return True
    num = sorted(num)
    step = (num[l]-num[0])/l
    while l > 0:
        if num[l] != num[l-1] + step:
            return False
        l -= 1
    return True

import unittest

class testAp(unittest.TestCase):
    def test(self):
        for inpt, otpt in {
                (1, 3, 5, 7, 9): True,
                (9, 1, 7, 5, 3): True,
                (1, 2, 4, 8, 16): False,
                (5, -1, 3, 1, -3): True,
                (1.5, 3, 0, 4.5, 6): True,
                }.items():
            self.assertEqual(ap(inpt),otpt)

unittest.main()
