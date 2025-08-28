### https://theweeklychallenge.org/blog/perl-weekly-challenge-336/
"""

Task 1: Equal Group

Submitted by: [42]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of integers.

   Write a script to return true if the given array can be divided into
   one or more groups: each group must be of the same size as the others,
   with at least two members, and with all members having the same value.

Example 1

Input: @ints = (1,1,2,2,2,2)
Output: true

Groups: (1,1), (2,2), (2,2)

Example 2

Input: @ints = (1,1,1,2,2,2,3,3)
Output: false

Groups: (1,1,1), (2,2,2), (3,3)

Example 3

Input: @ints = (5,5,5,5,5,5,7,7,7,7,7,7)
Output: true

Groups: (5,5,5,5,5,5), (7,7,7,7,7,7)

Example 4

Input: @ints = (1,2,3,4)
Output: false

Example 5

Input: @ints = (8,8,9,9,10,10,11,11)
Output: true

Groups: (8,8), (9,9), (10,10), (11,11)

Task 2: Final Score
"""
### solution by pokgopun@gmail.com

def eg(ints: tuple[int]) -> bool:
    l = len(ints)
    if l < 2:
        return False
    ints = sorted(ints)
    for d in range(2,l+1):
        if l % d != 0:
            continue
        #print("d=",d)
        for i in range(d,l+1,d):
            #print(ints[i-d:i])
            if len(set(ints[i-d:i])) != 1:
                break
        else:
            return True
    return False

import unittest

class TetEg(unittest.TestCase):
    def test(self):
        for inpt, otpt in {
                (1,1,2,2,2,2): True,
                (1,1,1,2,2,2,3,3): False,
                (5,5,5,5,5,5,7,7,7,7,7,7): True,
                (1,2,3,4): False,
                (8,8,9,9,10,10,11,11): True,
                (1,1): True,
                (1,1,1,2,2,2,3,3,3): True,
                (1,1,1,1,1,1,3,3,3): True,
                (1,1,1,3,3,3,3,3,3): True,
                }.items():
            #print(inpt)
            self.assertEqual(eg(inpt),otpt)

unittest.main()
