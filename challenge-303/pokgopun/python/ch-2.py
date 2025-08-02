### https://theweeklychallenge.org/blog/perl-weekly-challenge-303/
"""

Task 2: Delete and Earn

Submitted by: [40]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of integers, @ints.

   Write a script to return the maximum number of points you can earn by
   applying the following operation some number of times.
Pick any ints[i] and delete it to earn ints[i] points.
Afterwards, you must delete every element equal to ints[i] - 1
and every element equal to ints[i] + 1.

Example 1

Input: @ints = (3, 4, 2)
Output: 6

Delete 4 to earn 4 points, consequently, 3 is also deleted.
Finally delete 2 to earn 2 points.

Example 2

Input: @ints = (2, 2, 3, 3, 3, 4)
Output: 9

Delete a 3 to earn 3 points. All 2's and 4's are also deleted too.
Delete a 3 again to earn 3 points.
Delete a 3 once more to earn 3 points.
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 12^th January
   2025.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
"""
### solution by pokgopun@gmail.com

from typing import Tuple,Dict

class Ints:
    def __init__(self, ints: Tuple[int]):
        self.intc: Dict[int,int] = {}
        for n in ints:
            self.intc[n] = self.intc.get(n,0) + 1

    def check(self, n: int) -> int:
        score = n * self.intc.get(n,0)
        cost = 0
        for i in (n-1,n+1):
            cost += i * self.intc.get(i,0)
        def daeFunc() -> int:
            for i in range(-1,2,1):
                self.intc.pop(n+i,None)
            return score
        return score - cost, daeFunc

    def dae(self) -> int:
        score = 0
        while len(self.intc) > 0:
            mx, fx = None, None
            for n in self.intc.keys():
                if mx == None:
                    mx, fx = self.check(n)
                    continue
                m, f = self.check(n)
                if m > mx:
                    mx, fx = m, f
            score += fx()
        return score

import unittest

class TestDae(unittest.TestCase):
    def test(self):
        for inpt, otpt in {
                (3, 4, 2): 6,
                (2, 2, 3, 3, 3, 4): 9,
                }.items():
            self.assertEqual(Ints(inpt).dae(),otpt)

unittest.main()
