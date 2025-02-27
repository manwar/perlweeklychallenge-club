### https://theweeklychallenge.org/blog/perl-weekly-challenge-310/
"""

Task 2: Sort Odd Even

Submitted by: [39]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of integers.

   Write a script to sort odd index elements in decreasing order and even
   index elements in increasing order in the given array.

Example 1

Input: @ints = (4, 1, 2, 3)
Output: (2, 3, 4, 1)

Even index elements: 4, 2 => 2, 4 (increasing order)
Odd index elements : 1, 3 => 3, 1 (decreasing order)

Example 2

Input: @ints = (3, 1)
Output: (3, 1)

Example 3

Input: @ints = (5, 3, 2, 1, 4)
Output: (2, 3, 4, 1, 5)

Even index elements: 5, 2, 4 => 2, 4, 5 (increasing order)
Odd index elements : 3, 1 => 3, 1 (decreasing order)
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 2^nd March
   2025.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
"""
### solution by pokgopun@gmail.com

def soe(ints: tuple[int]) -> tuple[int]:
    l = len(ints)
    lst = [0 for i in range(l)]

    if l <= 2:
        return ints

    ol = l//2
    o = [ints[i*2+1] for i in range(ol)]
    o.sort(reverse=True)
    for i in range(ol):
        lst[i*2+1] = o[i]

    el = ol + l % 2 
    e = [ints[i*2] for i in range(el)]
    e.sort()
    for i in range(el):
        lst[i*2] = e[i]

    return tuple(lst)

import unittest

class TestSoe(unittest.TestCase):
    def test(self):
        for inpt, otpt in {
                (4, 1, 2, 3): (2, 3, 4, 1),
                (3, 1): (3, 1),
                (5, 3, 2, 1, 4): (2, 3, 4, 1, 5),
                }.items():
            self.assertEqual(soe(inpt),otpt)

unittest.main()
