### https://theweeklychallenge.org/blog/perl-weekly-challenge-271/
"""

Task 2: Sort by 1 bits

Submitted by: [43]Mohammad Sajid Anwar
     __________________________________________________________________

   You are give an array of integers, @ints.

   Write a script to sort the integers in ascending order by the number of
   1 bits in their binary representation. In case more than one integers
   have the same number of 1 bits then sort them in ascending order.

Example 1

Input: @ints = (0, 1, 2, 3, 4, 5, 6, 7, 8)
Output: (0, 1, 2, 4, 8, 3, 5, 6, 7)

0 = 0 one bits
1 = 1 one bits
2 = 1 one bits
4 = 1 one bits
8 = 1 one bits
3 = 2 one bits
5 = 2 one bits
6 = 2 one bits
7 = 3 one bits

Example 2

Input: @ints = (1024, 512, 256, 128, 64)
Output: (64, 128, 256, 512, 1024)

All integers in the given array have one 1-bits, so just sort them in ascending
order.
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 2nd June 2024.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
"""
### solution by pokgopun@gmail.com

def countBitOn(n):
    c = 0
    while n > 0:
        if n % 2 > 0:
            c += 1
        n = n // 2
    return c

def sortBitOn(nums: tuple):
    return tuple(
            sorted(
                nums,
                key = lambda x: (countBitOn(x), x)
                )
            )

import unittest

class TestSortBitOn(unittest.TestCase):
    def test(self):
        for inpt, otpt in {
                (0, 1, 2, 3, 4, 5, 6, 7, 8): (0, 1, 2, 4, 8, 3, 5, 6, 7),
                (1024, 512, 256, 128, 64): (64, 128, 256, 512, 1024),
                }.items():
            self.assertEqual(sortBitOn(inpt),otpt)

unittest.main()
