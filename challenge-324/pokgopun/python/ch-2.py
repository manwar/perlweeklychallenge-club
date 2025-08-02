### https://theweeklychallenge.org/blog/perl-weekly-challenge-324/
"""

Task 2: Total XOR

Submitted by: [43]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of integers.

   Write a script to return the sum of total XOR for every subset of given
   array.

Example 1

Input: @ints = (1, 3)
Output: 6

Subset [1],    total XOR = 1
Subset [3],    total XOR = 3
Subset [1, 3], total XOR => 1 XOR 3 => 2

Sum of total XOR => 1 + 3 + 2 => 6

Example 2

Input: @ints = (5, 1, 6)
Output: 28

Subset [5],       total XOR = 5
Subset [1],       total XOR = 1
Subset [6],       total XOR = 6
Subset [5, 1],    total XOR => 5 XOR 1 => 4
Subset [5, 6],    total XOR => 5 XOR 6 => 3
Subset [1, 6],    total XOR => 1 XOR 6 => 7
Subset [5, 1, 6], total XOR => 5 XOR 1 XOR 6 => 2

Sum of total XOR => 5 + 1 + 6 + 4 + 3 + 7 + 2 => 28

Example 3

Input: @ints = (3, 4, 5, 6, 7, 8)
Output: 480
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 8th June 2025.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
"""
### solution by pokgopun@gmail.com

from itertools import combinations

def txor(ints: tuple[int]) -> int:
    tx = 0
    for r in range(len(ints)):
        for cmb in combinations(ints,r+1):
            x = cmb[0]
            for n in cmb[1:]:
                x ^= n
            tx += x
    return tx

import unittest

class TestTxor(unittest.TestCase):
    def test(self):
        for inpt, otpt in {
                (1, 3): 6,
                (5, 1, 6): 28,
                (3, 4, 5, 6, 7, 8): 480,
                }.items():
            self.assertEqual(txor(inpt), otpt)

unittest.main()
