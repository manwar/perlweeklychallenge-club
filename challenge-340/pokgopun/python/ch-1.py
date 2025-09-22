### https://theweeklychallenge.org/blog/perl-weekly-challenge-340/
"""

Task 1: Duplicate Removals

Submitted by: [48]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a string, $str, consisting of lowercase English letters.

   Write a script to return the final string after all duplicate removals
   have been made. Repeat duplicate removals on the given string until we
   no longer can.

     A duplicate removal consists of choosing two adjacent and equal
     letters and removing them.

Example 1

Input: $str = 'abbaca'
Output: 'ca'

Step 1: Remove 'bb' => 'aaca'
Step 2: Remove 'aa' => 'ca'

Example 2

Input: $str = 'azxxzy'
Output: 'ay'

Step 1: Remove 'xx' => 'azzy'
Step 2: Remove 'zz' => 'ay'

Example 3

Input: $str = 'aaaaaaaa'
Output: ''

Step 1: Remove 'aa' => 'aaaaaa'
Step 2: Remove 'aa' => 'aaaa'
Step 3: Remove 'aa' => 'aa'
Step 4: Remove 'aa' => ''

Example 4

Input: $str = 'aabccba'
Output: 'a'

Step 1: Remove 'aa' => 'bccba'
Step 2: Remove 'cc' => 'bba'
Step 3: Remove 'bb' => 'a'

Example 5

Input: $str = 'abcddcba'
Output: ''

Step 1: Remove 'dd' => 'abccba'
Step 2: Remove 'cc' => 'abba'
Step 3: Remove 'bb' => 'aa'
Step 4: Remove 'aa' => ''

Task 2: Ascending Numbers
"""
### solution by pokgopun@gmail.com

import re

def dr(string: str) -> str:
    while True:
        l = len(string)
        string = re.sub(r'(.)\1','',string)
        if l == len(string):
            break
    return string

import unittest

class TestDr(unittest.TestCase):
    def test(self):
        for inpt, otpt in {
                'abbaca': 'ca',
                'azxxzy': 'ay',
                'aaaaaaaa': '',
                'aabccba': 'a',
                'abcddcba': '',
                }.items():
            self.assertEqual(dr(inpt),otpt)

unittest.main()
