### https://theweeklychallenge.org/blog/perl-weekly-challenge-261/
"""

Task 2: Multiply by Two

Submitted by: [46]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of integers, @ints and an integer $start..

   Write a script to do the followings:
a) Look for $start in the array @ints, if found multiply the number by 2
b) If not found stop the process otherwise repeat

   In the end return the final value.

Example 1

Input: @ints = (5,3,6,1,12) and $start = 3
Output: 24

Step 1: 3 is in the array so 3 x 2 = 6
Step 2: 6 is in the array so 6 x 2 = 12
Step 3: 12 is in the array so 12 x 2 = 24

24 is not found in the array so return 24.

Example 2

Input: @ints = (1,2,4,3) and $start = 1
Output: 8

Step 1: 1 is in the array so 1 x 2 = 2
Step 2: 2 is in the array so 2 x 2 = 4
Step 3: 4 is in the array so 4 x 2 = 8

8 is not found in the array so return 8.

Example 3

Input: @ints = (5,6,7) and $start = 2
Output: 2

2 is not found in the array so return 2.
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 24th March
   2024.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
"""
### solution by pokgopun@gmail.com

def MB2(ints: tuple, start: int):
    while start in ints:
        start *= 2
    return start

import unittest

class TestMB2(unittest.TestCase):
    def test(self):
        for (ints, start), otpt in {
                ((5,3,6,1,12),3): 24,
                ((1,2,4,3),1): 8,
                ((5,6,7),2): 2,
                }.items():
            self.assertEqual(MB2(ints,start), otpt)

unittest.main()
