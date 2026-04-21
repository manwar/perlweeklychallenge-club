### https://theweeklychallenge.org/blog/perl-weekly-challenge-368/
"""

Task 2: Big and Little Omega

Submitted by: [63]Roger Bell_West
     __________________________________________________________________

   You are given a positive integer $number and a mode flag $mode. If the
   mode flag is zero, calculate little omega (the count of all distinct
   prime factors of that number). If it is one, calculate big omega (the
   count of all prime factors including duplicates).

Example 1

Input: $number = 100061
       $mode = 0
Output: 3

   Prime factors are 13, 43, 179. Count is 3.

Example 2

Input: $number = 971088
       $mode = 0
Output: 3

   Prime factors are 2, 2, 2, 2, 3, 20231. Count of distinct numbers is 3.

Example 3

Input: $number = 63640
       $mode = 1
Output: 6

   Prime factors are 2, 2, 2, 5, 37, 43. Count including duplicates is 6.

Example 4

Input: $number = 988841
       $mode = 1
Output: 2

Example 5

Input: $number = 211529
       $mode = 0
Output: 2
     __________________________________________________________________

   By submitting a response to the challenge you agree that your name or
   pseudonym, any photograph you supply and any other personal information
   contained in your submission may be published on this website and the
   associated mobile app. Last date to submit the solution 23:59 (UK Time)
"""
### solution by pokgopun@gmail.com

from sympy import factorint

def balo(number:int, mode: int) -> int:
    return sum((1, e[1])[mode] for e in factorint(number).items())

import unittest

class TestBalo(unittest.TestCase):
    def test(self):
        for (number, mode), otpt in {
                (100061 , 0): 3 ,
                (971088 , 0): 3 ,
                (63640 , 1): 6 ,
                (988841 , 1): 2 ,
                (211529 , 0): 2,
                }.items():
            self.assertEqual(balo(number, mode), otpt)

unittest.main()
