### https://theweeklychallenge.org/blog/perl-weekly-challenge-355/
"""

Task 2: Mountain Array

Submitted by: [49]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of integers, @ints.

   Write a script to return true if the given array is a valid mountain
   array.
An array is mountain if and only if:
1) arr.length >= 3
and
2) There exists some i with 0 < i < arr.length - 1 such that:
arr[0] < arr[1]     < ... < arr[i - 1] < arr[i]
arr[i] > arr[i + 1] > ... > arr[arr.length - 1]

Example 1

Input: @ints = (1, 2, 3, 4, 5)
Output: false

Example 2

Input: @ints = (0, 2, 4, 6, 4, 2, 0)
Output: true

Example 3

Input: @ints = (5, 4, 3, 2, 1)
Output: false

Example 4

Input: @ints = (1, 3, 5, 5, 4, 2)
Output: false

Example 5

Input: @ints = (1, 3, 2)
Output: true
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 11th January
   2026.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
"""
### solution by pokgopun@gmail.com

def ma(ints: tuple[int]) -> bool:
    ti: list[int] = []
    for i in range(1,len(ints)):
        d = ints[i] - ints[i-1]
        if d == 0:
            return False
        if len(ti) == 0:
            if d < 0:
                return False
            ti = [d,0]
        else:
            if d * ti[0] < 0:
                ti[1] += 1
            ti[0] = d
    return ti[1]==1

import unittest

class TestMa(unittest.TestCase):
    def test(self):
        for inpt, otpt in {
                (1, 2, 3, 4, 5): False,
                (0, 2, 4, 6, 4, 2, 0): True,
                (5, 4, 3, 2, 1): False,
                (1, 3, 5, 5, 4, 2): False,
                (1, 3, 2): True,
                (0, 2, 4, 3, 5, 2, 0): False,
                }.items():
            self.assertEqual(ma(inpt),otpt)

unittest.main()
