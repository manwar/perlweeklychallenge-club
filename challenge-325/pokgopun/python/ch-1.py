### https://theweeklychallenge.org/blog/perl-weekly-challenge-325/
"""

Task 1: Consecutive One

Submitted by: [43]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a binary array containing only 0 or/and 1.

   Write a script to find out the maximum consecutive 1 in the given
   array.

Example 1

Input: @binary = (0, 1, 1, 0, 1, 1, 1)
Output: 3

Example 2

Input: @binary = (0, 0, 0, 0)
Output: 0

Example 3

Input: @binary = (1, 0, 1, 0, 1, 1)
Output: 2

Task 2: Final Price
"""
### solution by pokgopun@gmail.com

def co(bins: tuple[int]) -> int:
    c, mx = 0, 0
    n = len(bins)
    while n > 0:
        n -= 1
        if bins[n] == 0:
            if c == 0:
                continue
            if c > mx:
                #print("mx =",c)
                mx = c
            if n > 0 and n <= mx:
                #print(f'remaning {n} cannot make up mx')
                break
            c = 0
        else:
            c += 1
    if n ==0 and bins[n] > 0:
        #print("final mx update")
        if c > mx:
            #print("mx =",c)
            mx = c
    return mx

import unittest

class TestCo(unittest.TestCase):
    def test(self):
        for inpt, otpt in {
                (0, 1, 1, 0, 1, 1, 1): 3,
                (0, 0, 0, 0): 0,
                (1, 0, 1, 0, 1, 1): 2,
                (1, 0, 1, 1, 0, 1, 1): 2,
                (1, 0, 1, 1, 0, 0, 1, 1): 2,
                (0, 1, 1, 1, 0, 1, 1, 1): 3,
                (0, 1, 1, 1, 0, 1, 1, 1,0): 3,
                (0, 1, 1, 0, 0, 1, 1, 1,0): 3,
                (1, 1, 1, 0, 0, 1, 1, 1,0): 3,
                (1, 1, 1, 1, 0, 1, 1, 1,0): 4,
                }.items():
            #print(inpt,otpt)
            self.assertEqual(co(inpt),otpt)

unittest.main()
