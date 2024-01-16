### https://theweeklychallenge.org/blog/perl-weekly-challenge-251/
"""

Task 2: Lucky Numbers

Submitted by: [53]Mohammad S Anwar
     __________________________________________________________________

   You are given a m x n matrix of distinct numbers.

   Write a script to return the lucky number, if there is one, or -1 if
   not.
A lucky number is an element of the matrix such that it is
the minimum element in its row and maximum in its column.

Example 1

Input: $matrix = [ [ 3,  7,  8],
                   [ 9, 11, 13],
                   [15, 16, 17] ];
Output: 15

15 is the only lucky number since it is the minimum in its row
and the maximum in its column.

Example 2

Input: $matrix = [ [ 1, 10,  4,  2],
                   [ 9,  3,  8,  7],
                   [15, 16, 17, 12] ];
Output: 12

Example 3

Input: $matrix = [ [7 ,8],
                   [1 ,2] ];
Output: 7
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 14th January
   2024.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
"""
### solution by pokgopun@gmail.com

def luckynumber(tup: list):
    #print(tup)
    res = -1
    for i in range(len(tup)):
        mn = min(tup[i])
        #print("mn =",mn)
        j = tup[i].index(mn)
        if mn == max(e[j] for e in tup):
            res = mn
            break
    return res

import unittest

class TestLuckynumber(unittest.TestCase):
    def test(self):
        for inpt,otpt in {
                ( ( 3,  7,  8),
                   ( 9, 11, 13),
                   (15, 16, 17) ): 15,
                ( ( 1, 10,  4,  2),
                   ( 9,  3,  8,  7),
                   (15, 16, 17, 12) ): 12,
                ( (7 ,8),
                   (1 ,2) ): 7,
                }.items():
            self.assertEqual(luckynumber(inpt),otpt)

unittest.main()

 
