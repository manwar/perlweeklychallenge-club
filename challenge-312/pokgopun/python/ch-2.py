### https://theweeklychallenge.org/blog/perl-weekly-challenge-312/
"""

Task 2: Balls and Boxes

Submitted by: [53]Mohammad Sajid Anwar
     __________________________________________________________________

   There are $n balls of mixed colors: red, blue or green. They are all
   distributed in 10 boxes labelled 0-9.

   You are given a string describing the location of balls.

   Write a script to find the number of boxes containing all three colors.
   Return 0 if none found.

Example 1

Input: $str = "G0B1R2R0B0"
Output: 1

The given string describes there are 5 balls as below:
Box 0: Green(G0), Red(R0), Blue(B0) => 3 balls
Box 1: Blue(B1) => 1 ball
Box 2: Red(R2) => 1 ball

Example 2

Input: $str = "G1R3R6B3G6B1B6R1G3"
Output: 3

The given string describes there are 9 balls as below:
Box 1: Red(R1), Blue(B1), Green(G1) => 3 balls
Box 3: Red(R3), Blue(B3), Green(G3) => 3 balls
Box 6: Red(R6), Blue(B6), Green(G6) => 3 balls

Example 3

Input: $str = "B3B2G1B3"
Output: 0

Box 1: Green(G1) => 1 ball
Box 2: Blue(B2)  => 1 ball
Box 3: Blue(B3)  => 2 balls
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 16th March
   2025.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
"""
### solution by pokgopun@gmail.com

def bab(string: str) -> int:
    lst = ["" for i in range(10)]
    c = 0
    l = len(string)-1
    while l > 0:
        idx, clr = int(string[l]), string[l-1]
        if lst[idx] == None:
            continue
        lst[idx] += clr
        if len(set(lst[idx])) == 3:
            c += 1
            lst[idx] = None
        l -= 2
    return c

import unittest

class TestBab(unittest.TestCase):
    def test(self):
        for inpt, otpt in {
                "G0B1R2R0B0": 1,
                "G1R3R6B3G6B1B6R1G3": 3,
                "B3B2G1B3": 0,
                }.items():
            self.assertEqual(bab(inpt),otpt)

unittest.main()
