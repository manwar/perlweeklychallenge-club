### https://theweeklychallenge.org/blog/perl-weekly-challenge-268/
"""

Task 1: Magic Number

Submitted by: [47]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given two arrays of integers of same size, @x and @y.

   Write a script to find the magic number that when added to each
   elements of one of the array gives the second array. Elements order is
   not important.

Example 1

Input: @x = (3, 7, 5)
       @y = (9, 5, 7)
Output: 2

The magic number is 2.
@x = (3, 7, 5)
   +  2  2  2
@y = (5, 9, 7)

Example 2

Input: @x = (1, 2, 1)
       @y = (5, 4, 4)
Output: 3

The magic number is 3.
@x = (1, 2, 1)
   +  3  3  3
@y = (5, 4, 4)

Example 3

Input: @x = (2)
       @y = (5)
Output: 3

Task 2: Number Game
"""
### solution by pokgopun@gmail.com

def magicNumber(x: tuple, y: tuple):
    l = len(x)
    if l == 0 or l != len(y):
        return None
    x, y = sorted(x), sorted(y)
    d = y[0]-x[0]
    for i in range(1,l):
        if d != y[i]-x[i]:
            return None
    return d

import unittest

class TestMagicNumber(unittest.TestCase):
    def test(self):
        for (x,y), ans in {
                ((3, 7, 5),(9, 5, 7)): 2,
                ((1, 2, 1),(5, 4, 4)): 3,
                ((2,),(5,)): 3,
                }.items():
            self.assertEqual(magicNumber(x,y),ans)

unittest.main()
