### https://theweeklychallenge.org/blog/perl-weekly-challenge-358/
"""

Task 1: Max Str Value

Submitted by: [47]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of alphanumeric string, @strings.

   Write a script to find the max value of alphanumeric string in the
   given array. The numeric representation of the string, if it comprises
   of digits only otherwise length of the string.

Example 1

Input: @strings = ("123", "45", "6")
Output: 123

"123" -> 123
"45"  -> 45
"6"   -> 6

Example 2

Input: @strings = ("abc", "de", "fghi")
Output: 4

"abc"  -> 3
"de"   -> 2
"fghi" -> 4

Example 3

Input: @strings = ("0012", "99", "a1b2c")
Output: 99

"0012"  -> 12
"99"    -> 99
"a1b2c" -> 5

Example 4

Input: @strings = ("x", "10", "xyz", "007")
Output: 10

"x"   -> 1
"xyz" -> 3
"007" -> 7
"10"  -> 10

Example 5

Input: @strings = ("hello123", "2026", "perl")
Output: 2026

"hello123" -> 8
"perl"     -> 4
"2026"     -> 2026

Task 2: Encrypted String
"""
### solution by pokgopun@gmail.com
def msv(strings: tuple[str]) -> int:
    return max(int(e) if e.isdecimal() else len(e) for e in strings)

import unittest

class TestMsv(unittest.TestCase):
    def test(self):
        for inpt, otpt in {
                ("123", "45", "6"): 123,
                ("abc", "de", "fghi"): 4,
                ("0012", "99", "a1b2c"): 99,
                ("x", "10", "xyz", "007"): 10,
                ("hello123", "2026", "perl"): 2026,
                }.items():
            self.assertEqual(msv(inpt), otpt)

unittest.main()
