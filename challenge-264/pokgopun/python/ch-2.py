### https://theweeklychallenge.org/blog/perl-weekly-challenge-264/
"""

Task 2: Target Array

Submitted by: [48]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given two arrays of integers, @source and @indices. The
   @indices can only contains integers 0 <= i < size of @source.

   Write a script to create target array by insert at index $indices[i]
   the value $source[i].

Example 1

Input: @source  = (0, 1, 2, 3, 4)
       @indices = (0, 1, 2, 2, 1)
Output: (0, 4, 1, 3, 2)

@source  @indices  @target
0        0         (0)
1        1         (0, 1)
2        2         (0, 1, 2)
3        2         (0, 1, 3, 2)
4        1         (0, 4, 1, 3, 2)

Example 2

Input: @source  = (1, 2, 3, 4, 0)
       @indices = (0, 1, 2, 3, 0)
Output: (0, 1, 2, 3, 4)

@source  @indices  @target
1        0         (1)
2        1         (1, 2)
3        2         (1, 2, 3)
4        3         (1, 2, 3, 4)
0        0         (0, 1, 2, 3, 4)

Example 3

Input: @source  = (1)
       @indices = (0)
Output: (1)
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 14th April
   2024.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
"""
### solution by pokgopun@gmail.com

def target(source,indices):
    result = list()
    for i in range(len(source)):
        result.insert(indices[i],source[i])
    return tuple(result)

import unittest

class TestTarget(unittest.TestCase):
    def test(self):
        for (source,indices), result in {
                ((0, 1, 2, 3, 4), (0, 1, 2, 2, 1)): (0, 4, 1, 3, 2),
                ((1, 2, 3, 4, 0), (0, 1, 2, 3, 0)): (0, 1, 2, 3, 4),
                ((1,), (0,)): (1,),
                }.items():
            self.assertEqual(target(source,indices),result)

unittest.main()
