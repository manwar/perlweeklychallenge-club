### https://theweeklychallenge.org/blog/perl-weekly-challenge-258/
"""

Task 2: Sum of Values

Submitted by: [43]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of integers, @int and an integer $k.

   Write a script to find the sum of values whose index binary
   representation has exactly $k number of 1-bit set.

Example 1

Input: @ints = (2, 5, 9, 11, 3), $k = 1
Output: 17

Binary representation of index 0 = 0
Binary representation of index 1 = 1
Binary representation of index 2 = 10
Binary representation of index 3 = 11
Binary representation of index 4 = 100

So the indices 1, 2 and 4 have total one 1-bit sets.
Therefore the sum, $ints[1] + $ints[2] + $ints[3] = 17

Example 2

Input: @ints = (2, 5, 9, 11, 3), $k = 2
Output: 11

Example 3

Input: @ints = (2, 5, 9, 11, 3), $k = 0
Output: 2
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 1st March 2024.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
"""
### solution by pokgopun@gmail.com

def SOV(ints: tuple, k: int):
    return sum(
            ints[i] for i in range(len(ints))
            if sum(
                int(e) for e in bin(i).lstrip('0b')
                ) == k
           )
import unittest

class TestSOV(unittest.TestCase):
    def test(self):
        for (ints, k), otpt in {
                ((2, 5, 9, 11, 3), 1): 17,
                ((2, 5, 9, 11, 3), 2): 11,
                ((2, 5, 9, 11, 3), 0): 2,
                }.items():
            self.assertEqual(SOV(ints,k),otpt)

unittest.main()
