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

def dae(ints: Tuple[int]) -> int:
    intc: Dict[int,int] = {}
    for n in ints:
        intc[n] = intc.get(n, 0) + 1
    score = 0
    while len(intc) > 0:
        k = None
        mx = None
        for n, c in intc.items():
            v = n * c
            vp = n - 1
            cp = intc.get(vp, None)
            if cp is not None:
                v -= vp * cp
            vn = n + 1
            cn = intc.get(vn, None)
            if cn is not None:
                v -= vn * cn
            if k is None:
                k = n
                mx = v
                continue
            if v > mx:
                mx = v
                k = n
        score += k * intc[k]
        intc.pop(k)
        if intc.get(k-1, None) is not None:
            intc.pop(k-1)
        if intc.get(k+1, None) is not None:
            intc.pop(k+1)
    return score

import unittest

class TestDae(unittest.TestCase):
    def test(self):
        for inpt, otpt in {
                (3, 4, 2): 6,
                (2, 2, 3, 3, 3, 4): 9,
                }.items():
            self.assertEqual(dae(inpt),otpt)

unittest.main()
