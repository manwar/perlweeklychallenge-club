### https://theweeklychallenge.org/blog/perl-weekly-challenge-284/
"""

Task 2: Relative Sort

Submitted by: [41]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given two list of integers, @list1 and @list2. The elements in
   the @list2 are distinct and also in the @list1.

   Write a script to sort the elements in the @list1 such that the
   relative order of items in @list1 is same as in the @list2. Elements
   that is missing in @list2 should be placed at the end of @list1 in
   ascending order.

Example 1

Input: @list1 = (2, 3, 9, 3, 1, 4, 6, 7, 2, 8, 5)
       @list2 = (2, 1, 4, 3, 5, 6)
Ouput: (2, 2, 1, 4, 3, 3, 5, 6, 7, 8, 9)

Example 2

Input: @list1 = (3, 3, 4, 6, 2, 4, 2, 1, 3)
       @list2 = (1, 3, 2)
Ouput: (1, 3, 3, 3, 2, 2, 4, 4, 6)

Example 3

Input: @list1 = (3, 0, 5, 0, 2, 1, 4, 1, 1)
       @list2 = (1, 0, 3, 2)
Ouput: (1, 1, 1, 0, 0, 3, 2, 4, 5)
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 1st September
   2024.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
"""
### solution by pokgopun@gmail.com

def rs(ints1, ints2):
    dct = dict()
    l = len(ints2)
    for i in range(l):
        dct[ints2[i]] = i
    mn = min(set(ints1).difference(set(ints2)))
    return tuple(
            sorted(ints1,key=lambda x: dct.get(x, l+x-mn))
            )

import unittest

class TestRs(unittest.TestCase):
    def test(self):
        for (ints1,ints2), ints in {
                ((2, 3, 9, 3, 1, 4, 6, 7, 2, 8, 5), (2, 1, 4, 3, 5, 6)): (2, 2, 1, 4, 3, 3, 5, 6, 7, 8, 9),
                ((3, 3, 4, 6, 2, 4, 2, 1, 3), (1, 3, 2)): (1, 3, 3, 3, 2, 2, 4, 4, 6),
                ((3, 0, 5, 0, 2, 1, 4, 1, 1), (1, 0, 3, 2)): (1, 1, 1, 0, 0, 3, 2, 4, 5),
                }.items():
            self.assertEqual(rs(ints1,ints2),ints)

unittest.main()
