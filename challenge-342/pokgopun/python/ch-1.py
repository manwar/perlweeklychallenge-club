### https://theweeklychallenge.org/blog/perl-weekly-challenge-342/
"""

Task 1: Balance String

Submitted by: [46]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a string made up of lowercase English letters and digits
   only.

   Write a script to format the give string where no letter is followed by
   another letter and no digit is followed by another digit. If there are
   multiple valid rearrangements, always return the lexicographically
   smallest one. Return empty string if it is impossible to format the
   string.

Example 1

Input: $str = "a0b1c2"
Output: "0a1b2c"

Example 2

Input: $str = "abc12"
Output: "a1b2c"

Example 3

Input: $str = "0a2b1c3"
Output: "0a1b2c3"

Example 4

Input: $str = "1a23"
Output: ""

Example 5

Input: $str = "ab123"
Output: "1a2b3"

Task 2: Max Score
"""
### solution by pokgopun@gmail.com

def bs(string: str) -> str:
    chars = sorted(string + "_")
    m = chars.index("_")
    l = len(string)
    d = l - 2*m
    match d:
        case 0:
            return "".join( chars[i] + chars[m+i+1] for i in range(m) )
        case 1:
            return "".join( chars[m+i+1] + chars[i] for i in range(m) ) + chars[l]
        case -1:
            return "".join( chars[i] + chars[m+i+1] for i in range(m-1) ) + chars[m-1]
    return ""

import unittest

class TestBs(unittest.TestCase):
    def test(self):
        for inpt, otpt in {
                "a0b1c2": "0a1b2c",
                "abc12": "a1b2c",
                "0a2b1c3": "0a1b2c3",
                "1a23": "",
                "ab123": "1a2b3",
                }.items():
            self.assertEqual(bs(inpt),otpt)

unittest.main()
