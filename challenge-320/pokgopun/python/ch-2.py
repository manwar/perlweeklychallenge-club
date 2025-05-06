### https://theweeklychallenge.org/blog/perl-weekly-challenge-320/
"""

Task 2: Sum Difference

Submitted by: [44]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of positive integers.

   Write a script to return the absolute difference between digit sum and
   element sum of the given array.

Example 1

Input: @ints = (1, 23, 4, 5)
Output: 18

Element sum: 1 + 23 + 4 + 5 => 33
Digit sum: 1 + 2 + 3 + 4 + 5 => 15
Absolute difference: | 33 - 15 | => 18

Example 2

Input: @ints = (1, 2, 3, 4, 5)
Output: 0

Element sum: 1 + 2 + 3 + 4 + 5 => 15
Digit sum: 1 + 2 + 3 + 4 + 5 => 15
Absolute difference: | 15 - 15 | => 0

Example 3

Input: @ints = (1, 2, 34)
Output: 27

Element sum: 1 + 2 + 34 => 37
Digit sum: 1 + 2 + 3 + 4 => 10
Absolute difference: | 37 - 10 | => 27
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 11th May 2025.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
"""
### solution by pokgopun@gmail.com

def sd(ints: tuple[int]) -> int:
    return abs(
            sum(ints) - sum(
                int(d) for d in "".join(
                    str(e) for e in ints
                    )
                )
            )

import unittest

class TestSd(unittest.TestCase):
    def test(self):
        for inpt, otpt in {
                (1, 23, 4, 5): 18,
                (1, 2, 3, 4, 5): 0,
                (1, 2, 34): 27,
                }.items():
            self.assertEqual(sd(inpt), otpt)

unittest.main()

