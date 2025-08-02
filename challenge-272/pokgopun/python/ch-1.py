### https://theweeklychallenge.org/blog/perl-weekly-challenge-272/
"""

Task 1: Defang IP Address

Submitted by: [45]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a valid IPv4 address.

   Write a script to return the defanged version of the given IP address.

     A defanged IP address replaces every period “.” with “[.]".

Example 1

Input: $ip = "1.1.1.1"
Output: "1[.]1[.]1[.]1"

Example 2

Input: $ip = "255.101.1.0"
Output: "255[.]101[.]1[.]0"

Task 2: String Score
"""
### solution by pokgopun@gmail.com

def dfip(string: str):
    return string.replace(".","[.]")

import unittest

class TestDfip (unittest.TestCase):
    def test(self):
        for inpt, otpt in {
                "1.1.1.1": "1[.]1[.]1[.]1",
                "255.101.1.0": "255[.]101[.]1[.]0",
                }.items():
            self.assertEqual(dfip(inpt),otpt)

unittest.main()
