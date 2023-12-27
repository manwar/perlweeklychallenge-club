### https://theweeklychallenge.org/blog/perl-weekly-challenge-249/
"""

Task 1: Shortest Distance

Submitted by: [66]Mohammad S Anwar
     __________________________________________________________________

   You are given an array of integers with even number of elements.

   Write a script to divide the given array into equal pairs such that:
a) Each element belongs to exactly one pair.
b) The elements present in a pair are equal.

Example 1

Input: @ints = (3, 2, 3, 2, 2, 2)
Output: (2, 2), (3, 3), (2, 2)

There are 6 elements in @ints.
They should be divided into 6 / 2 = 3 pairs.
@ints is divided into the pairs (2, 2), (3, 3), and (2, 2) satisfying all the co
nditions.

Example 2

Input: @ints = (1, 2, 3, 4)
Output: ()

There is no way to divide @ints 2 pairs such that the pairs satisfy every condit
ion.

Task 2: DI String Match
"""
### solution by pokgopun@gmail.com

from itertools import chain

def equalPairs(tup: tuple):
    return tuple(
            chain.from_iterable(
                ( (e,e) for c in range(tup.count(e)//2 ) )
                for e in set(tup)
                )
            )

import unittest

class TestEqualPairs(unittest.TestCase):
    def test1(self):
        for inpt,otpt in {
                (3, 2, 3, 2, 2, 2): ((2, 2), (3, 3), (2, 2)),
                (1, 2, 3, 4): (),
                }.items():
            self.assertEqual(sorted(equalPairs(inpt)),sorted(otpt))

unittest.main()
