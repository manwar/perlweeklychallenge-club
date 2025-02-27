### https://theweeklychallenge.org/blog/perl-weekly-challenge-310/
"""

Task 1: Arrays Intersection

Submitted by: [38]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a list of array of integers.

   Write a script to return the common elements in all the arrays.

Example 1

Input: $list = ( [1, 2, 3, 4], [4, 5, 6, 1], [4, 2, 1, 3] )
Output: (1, 4)

Example 2

Input: $list = ( [1, 0, 2, 3], [2, 4, 5] )
Output: (2)

Example 3

Input: $list = ( [1, 2, 3], [4, 5], [6] )
Output: ()

Task 2: Sort Odd Even
"""
### solution by pokgopun@gmail.com

def ai(tup: tuple[tuple[int]]) -> tuple[int]:
    l = len(tup)
    t =  tup[0]
    for e in tup[1:]:
        t = t + e
    return tuple(
            e for e in set(t) if t.count(e) == l
            )

import unittest

class TestAI(unittest.TestCase):
    def test(self):
        for inpt, otpt in {
                ( (1, 2, 3, 4), (4, 5, 6, 1), (4, 2, 1, 3) ): (1, 4),
                ( (1, 0, 2, 3), (2, 4, 5) ): (2,),
                ( (1, 2, 3), (4, 5), (6,) ): (),
                }.items():
            self.assertEqual(ai(inpt),otpt)

unittest.main()
