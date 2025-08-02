### https://theweeklychallenge.org/blog/perl-weekly-challenge-322/
"""

Task 2: Rank Array

Submitted by: [46]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of integers.

   Write a script to return an array of the ranks of each element: the
   lowest value has rank 1, next lowest rank 2, etc. If two elements are
   the same then they share the same rank.

Example 1

Input: @ints = (55, 22, 44, 33)
Output: (4, 1, 3, 2)

Example 2

Input: @ints = (10, 10, 10)
Output: (1, 1, 1)

Example 3

Input: @ints = (5, 1, 1, 4, 3)
Output: (4, 1, 1, 3, 2)
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 25th May 2025.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
"""
### solution by pokgopun@gmail.com

def ra(ints: tuple[int]) -> tuple[int]:
    a = [(ints[i],i) for i in range(len(ints)) ]
    a.sort()
    r = 1
    b = [(a[0][1],r)]
    for i in range(1,len(a)):
        if a[i][0] > a[i-1][0]:
            r += 1
        b.append((a[i][1],r))
    return tuple(e[1] for e in sorted(b))

import unittest

class TestRa(unittest.TestCase):
    def test(self):
        for inpt, otpt in {
                (55, 22, 44, 33):(4, 1, 3, 2),
                (10, 10, 10):(1, 1, 1),
                (5, 1, 1, 4, 3): (4, 1, 1, 3, 2),
                }.items():
            self.assertEqual(ra(inpt),otpt)

unittest.main()
