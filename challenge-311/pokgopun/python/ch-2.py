### https://theweeklychallenge.org/blog/perl-weekly-challenge-311/
"""

Task 2: Group Digit Sum

Submitted by: [40]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a string, $str, made up of digits, and an integer, $int,
   which is less than the length of the given string.

   Write a script to divide the given string into consecutive groups of
   size $int (plus one for leftovers if any). Then sum the digits of each
   group, and concatenate all group sums to create a new string. If the
   length of the new string is less than or equal to the given integer
   then return the new string, otherwise continue the process.

Example 1

Input: $str = "111122333", $int = 3
Output: "359"

Step 1: "111", "122", "333" => "359"

Example 2

Input: $str = "1222312", $int = 2
Output: "76"

Step 1: "12", "22", "31", "2" => "3442"
Step 2: "34", "42" => "76"

Example 3

Input: $str = "100012121001", $int = 4
Output: "162"

Step 1: "1000", "1212", "1001" => "162"
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 9^th March
   2025.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
"""
### solution by pokgopun@gmail.com

def gds(string: str, n: int) -> str:
    while True:
        l = len(string)
        if l <= n:
            break
        string = "".join(
                str(d) for d in (
                    sum(
                        int(e) for e in string[i*n:i*n+n]
                        ) for i in range(l//n + (l%n > 0))
                    )
                )
    return string

import unittest

class TestGds(unittest.TestCase):
    def test(self):
        for (string, n), otpt in {
                ("111122333", 3): "359",
                ("1222312", 2): "76",
                ("100012121001", 4): "162",
                ("100012121001", 3): "81",
                ("100012121001", 5): "261",
                ("99990999909999", 5): "216",
                }.items():
            self.assertEqual(gds(string, n), otpt)

unittest.main()
