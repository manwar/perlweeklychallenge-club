### https://theweeklychallenge.org/blog/perl-weekly-challenge-356/
"""

Task 1: Kolakoski Sequence

Submitted by: [51]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an integer, $int > 3.

   Write a script to generate the Kolakoski Sequence of given length $int
   and return the count of 1 in the generated sequence. Please follow the
   [52]wikipedia page for more informations.

Example 1

Input: $int = 4
Output: 2

(1)(22)(11)(2) => 1221

Example 2

Input: $int = 5
Output: 3

(1)(22)(11)(2)(1) => 12211

Example 3

Input: $int = 6
Output: 3

(1)(22)(11)(2)(1)(22) => 122112

Example 4

Input: $int = 7
Output: 4

(1)(22)(11)(2)(1)(22)(1) => 1221121

Example 5

Input: $int = 8
Output: 4

(1)(22)(11)(2)(1)(22)(1)(22) => 12211212

Task 2: Who Wins
"""
### solution by pokgopun@gmail.com

def ks(n: int) -> int:
    lst = [1,2,2]
    t = 3
    while n > len(lst):
	    l = lst[t-1]
	    e = 2 - (t % 2)
	    for i in range(l):
	        lst.append(e)
	    t += 1
    #print(n,":",lst,"=>",lst[:n])
    return lst[:n].count(1)

import unittest

class TestKs(unittest.TestCase):
    def test(self):
        for inpt, otpt in {
                4: 2,
                5: 3,
                6: 3,
                7: 4,
                8: 4,
                }.items():
            self.assertEqual(ks(inpt),otpt)

unittest.main()
