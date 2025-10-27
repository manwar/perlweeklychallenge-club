### https://theweeklychallenge.org/blog/perl-weekly-challenge-345/
"""

Task 1: Peak Positions

Submitted by: [43]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of integers, @ints.

   Find all the peaks in the array, a peak is an element that is strictly
   greater than its left and right neighbours. Return the indices of all
   such peak positions.

Example 1

Input: @ints = (1, 3, 2)
Output: (1)

Example 2

Input: @ints = (2, 4, 6, 5, 3)
Output: (2)

Example 3

Input: @ints = (1, 2, 3, 2, 4, 1)
Output: (2, 4)

Example 4

Input: @ints = (5, 3, 1)
Output: (0)

Example 5

Input: @ints = (1, 5, 1, 5, 1, 5, 1)
Output: (1, 3, 5)

Task 2: Last Visitor
"""
### solution by pokgopun@gmail.com

def pp(ints: tuple[int]) -> tuple[int]:
    l = len(ints)
    if l < 2:
        return tuple(range(l))
    i = 0
    p = []
    while i < l:
        if i == l - 1:
            p.append(i)
            break
        if ints[i] < ints[i+1]:
            i += 1
            continue
        if ints[i] > ints[i+1]:
            p.append(i)
        i += 2
        if i == l - 1 and ints[i] <= ints[i-1]:
            break
    return tuple(p)

import unittest

class TestPp(unittest.TestCase):
    def test(self):
        for inpt, otpt in {
                (1, 3, 2): (1,),
                (2, 4, 6, 5, 3): (2,),
                (1, 2, 3, 2, 4, 1): (2, 4),
                (5, 3, 1): (0,),
                (1, 5, 1, 5, 1, 5, 1): (1, 3, 5),
                (2, 3, 4): (2,),
                (2, 2, 2): (),
                (3, 3): (),
                (5, 3): (0,),
                (5, 7): (1,),
                (7,): (0,),
                (): (),
                }.items():
            #print(inpt,otpt)
            self.assertEqual(pp(inpt),otpt)

unittest.main()
