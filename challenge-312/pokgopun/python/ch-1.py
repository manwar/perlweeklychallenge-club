### https://theweeklychallenge.org/blog/perl-weekly-challenge-312/
"""

Task 1: Minimum Time

Submitted by: [52]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a typewriter with lowercase english letters a to z
   arranged in a circle.

   Task 1

   Typing a character takes 1 sec. You can move pointer one character
   clockwise or anti-clockwise.

   The pointer initially points at a.

   Write a script to return minimum time it takes to print the given
   string.

Example 1

Input: $str = "abc"
Output: 5

The pointer is at 'a' initially.
1 sec - type the letter 'a'
1 sec - move pointer clockwise to 'b'
1 sec - type the letter 'b'
1 sec - move pointer clockwise to 'c'
1 sec - type the letter 'c'

Example 2

Input: $str = "bza"
Output: 7

The pointer is at 'a' initially.
1 sec - move pointer clockwise to 'b'
1 sec - type the letter 'b'
1 sec - move pointer anti-clockwise to 'a'
1 sec - move pointer anti-clockwise to 'z'
1 sec - type the letter 'z'
1 sec - move pointer clockwise to 'a'
1 sec - type the letter 'a'

Example 3

Input: $str = "zjpc"
Output: 34

Task 2: Balls and Boxes
"""
### solution by pokgopun@gmail.com

def mt(string: str) -> int:
    o = ord('a')
    l = ord('z') - o + 1
    t = len(string)
    p = 0
    for c in string:
        n = ord(c) - o
        if n == p:
            continue
        mn = min(p,n)
        mx = max(p,n)
        t += min(mx-mn,l-mx+mn)
        p = n
    return t

import unittest

class TestMt(unittest.TestCase):
    def test(self):
        for inpt, otpt in {
                "abc": 5,
                "bza": 7,
                "zjpc": 34,
                }.items():
            self.assertEqual(mt(inpt),otpt)

unittest.main()
