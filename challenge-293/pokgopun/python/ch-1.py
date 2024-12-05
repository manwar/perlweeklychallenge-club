### https://theweeklychallenge.org/blog/perl-weekly-challenge-293/
"""

Task 1: Similar Dominos

Submitted by: [40]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a list of dominos, @dominos.

   Write a script to return the number of dominoes that are similar to any
   other domino.

     $dominos[i] = [a, b] and $dominos[j] = [c, d] are same if either (a
     = c and b = d) or (a = d and b = c).

Example 1

Input: @dominos = ([1, 3], [3, 1], [2, 4], [6, 8])
Output: 2

Similar Dominos: $dominos[0], $dominos[1]

Example 2

Input: @dominos = ([1, 2], [2, 1], [1, 1], [1, 2], [2, 2])
Output: 3

Similar Dominos: $dominos[0], $dominos[1], $dominos[3]

Task 2: Boomerang
"""
### solution by pokgopun@gmail.com

from typing import Tuple,Dict

def sd(dominos:Tuple[Tuple[int]]):
    dmn: Dict[Tuple[int],int] = {}
    for a,b in dominos:
        if a > b:
            a, b = b, a
        k = (a, b)
        dmn[k] = dmn.get(k,0) + 1
    count = 0
    for v in dmn.values():
        if v > 1:
            count += v
    return count
    
import unittest

class TestSd(unittest.TestCase):
    def test(self):
        for inpt,otpt in {
                ((1, 3), (3, 1), (2, 4), (6, 8)): 2,
                ((1, 2), (2, 1), (1, 1), (1, 2), (2, 2)): 3,
                }.items():
            self.assertEqual(sd(inpt),otpt)

unittest.main()
