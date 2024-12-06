### https://theweeklychallenge.org/blog/perl-weekly-challenge-295/
"""

Task 2: Jump Game

Submitted by: [45]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of integers, @ints.

   Write a script to find the minimum number of jumps to reach the last
   element. $ints[$i] represents the maximum length of a forward jump from
   the index $i. In case last element is unreachable then return -1.

Example 1

Input: @ints = (2, 3, 1, 1, 4)
Output: 2

Jump 1 step from index 0 then 3 steps from index 1 to the last element.

Example 2

Input: @ints = (2, 3, 0, 4)
Output: 2

Example 3

Input: @ints = (2, 0, 0, 4)
Output: -1
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 17th November
   2024.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
"""
### solution by pokgopun@gmail.com

from typing import Tuple

def jg(ints: Tuple[int]) -> int:
    l = len(ints)
    if l == 1:
        return 0
    count = -1
    for i in range(min(ints[0], l-1), 0, -1):
        n = jg(ints[i:])
        #print("=>", ints[i:],n)
        if n == -1:
            continue
        if count == -1:
            count = 1 + n
        else:
            count = min(count, 1 + n)
    return count

import unittest

class TestJg(unittest.TestCase):
    def test(self):
        for inpt, otpt in {
                (2, 3, 1, 1, 4): 2,
                (2, 3, 0, 4): 2,
                (2, 0, 0, 4): -1,
                }.items():
            #print(inpt,otpt)
            self.assertEqual(jg(inpt),otpt)

unittest.main()
