### https://theweeklychallenge.org/blog/perl-weekly-challenge-276/
"""

Task 2: Maximum Frequency

Submitted by: [42]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of positive integers, @ints.

   Write a script to return the total number of elements in the given
   array which have the highest frequency.

Example 1

Input: @ints = (1, 2, 2, 4, 1, 5)
Ouput: 4

The maximum frequency is 2.
The elements 1 and 2 has the maximum frequency.

Example 2

Input: @ints = (1, 2, 3, 4, 5)
Ouput: 5

The maximum frequency is 1.
The elements 1, 2, 3, 4 and 5 has the maximum frequency.
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 7th July 2024.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
"""
### solution by pokgopun@gmail.com

def maxFreq(ints: tuple):
    ic = tuple((e, ints.count(e)) for e in set(ints))
    mf = max(e[1] for e in ic)
    return sum( mf for e in ic if e[1]==mf)

import unittest

class TestMaxFreq(unittest.TestCase):
    def test(self):
        for inpt,otpt in {
                (1, 2, 2, 4, 1, 5): 4,
                (1, 2, 3, 4, 5): 5,
                }.items():
            self.assertEqual(maxFreq(inpt),otpt)

unittest.main()
