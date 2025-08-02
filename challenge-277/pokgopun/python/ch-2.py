### https://theweeklychallenge.org/blog/perl-weekly-challenge-277/
"""

Task 2: Strong Pair

Submitted by: [54]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of integers, @ints.

   Write a script to return the count of all strong pairs in the given
   array.

     A pair of integers x and y is called strong pair if it satisfies: 0
     < |x - y| < min(x, y).

Example 1

Input: @ints = (1, 2, 3, 4, 5)
Ouput: 4

Strong Pairs: (2, 3), (3, 4), (3, 5), (4, 5)

Example 2

Input: @ints = (5, 7, 1, 7)
Ouput: 1

Strong Pairs: (5, 7)
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 14th July 2024.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
"""
### solution by pokgopun@gmail.com

def strongPair(ints):
    ints = tuple(set(ints))
    c = 0
    l = len(ints)
    for i in range(l-1):
        for j in range(i+1,l):
            x, y = ints[i], ints[j]
            if x == y:
                continue
            if max(x,y) < 2*min(x,y):
                c += 1
    return c

import unittest

class TestStrongPair(unittest.TestCase):
    def test(self):
        for ints, count in {
                (1, 2, 3, 4, 5): 4,
                (5, 7, 1, 7): 1,
                }.items():
            self.assertEqual(strongPair(ints),count)

unittest.main()
