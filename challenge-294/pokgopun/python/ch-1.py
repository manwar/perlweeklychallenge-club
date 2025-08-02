### https://theweeklychallenge.org/blog/perl-weekly-challenge-294/
"""

Task 1: Consecutive Sequence

Submitted by: [39]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an unsorted array of integers, @ints.

   Write a script to return the length of the longest consecutive elements
   sequence. Return -1 if none found. The algorithm must runs in O(n)
   time.

Example 1

Input: @ints = (10, 4, 20, 1, 3, 2)
Output: 4

The longest consecutive sequence (1, 2, 3, 4).
The length of the sequence is 4.

Example 2

Input: @ints = (0, 6, 1, 8, 5, 2, 4, 3, 0, 7)
Output: 9

Example 3

Input: @ints = (10, 30, 20)
Output: -1

Task 2: Next Permutation
"""
### solution by pokgopun@gmail.com

def lcs(ints: tuple) -> int:
    ints = sorted(ints)
    #print(ints)
    if len(ints) < 2:
        return -1
    p = ints[0]
    count = 0
    mx = 0
    for n in sorted(ints[1:]):
        #print("p =", p)
        if n - p == 1:
            count += 1
            if count > mx:
                mx = count
        else:
           count = 0
        #print("count =", count, "mx =", mx)
        p = n
    if mx == 0:
        return -1
    return mx + 1

import unittest

class TestLcs(unittest.TestCase):
    def test(self):
        for inpt, otpt in {
                (10, 4, 20, 1, 3, 2): 4,
                (0, 6, 1, 8, 5, 2, 4, 3, 0, 7): 9,
                (10, 30, 20): -1
                }.items():
            self.assertEqual(lcs(inpt),otpt)

unittest.main()
