### https://theweeklychallenge.org/blog/perl-weekly-challenge-367/
"""

Task 1: Max Odd Binary

Submitted by: [61]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a binary string that has at least one ‘1’.

   Write a script to rearrange the bits in such a way that the resulting
   binary number is the maximum odd binary number and return the resulting
   binary string. The resulting string can have leading zeros.

Example 1

Input: $str = "1011"
Output: "1101"

"1101" is max odd binary (13).

Example 2

Input: $str = "100"
Output: "001"

"001" is max odd binary (1).

Example 3

Input: $str = "111000"
Output: "110001"

Example 4

Input: $str = "0101"
Output: "1001"

Example 5

Input: $str = "1111"
Output: "1111"

Task 2: Conflict Events
"""
### solution by pokgopun@gmail.com

def mob(string: str) -> str:
    #return "".join(sorted(string,reverse=True)[1:])+"1"
    c = string.count("1")
    l = len(string)
    if c == 0 or c == l:
        return string
    return "1" * (c-1) + "0" * (l-c)  + "1"

import unittest

class TestMob(unittest.TestCase):
    def test(self):
        for inpt, otpt in {
                "1011" : "1101" ,
                "100" : "001" ,
                "111000" : "110001" ,
                "0101" : "1001" ,
                "1111" : "1111",
                }.items():
            self.assertEqual(mob(inpt), otpt)

unittest.main()
