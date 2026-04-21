### https://theweeklychallenge.org/blog/perl-weekly-challenge-368/
"""

Task 1: Make it Bigger

Submitted by: [62]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a given a string number and a character digit.

   Write a script to remove exactly one occurrence of the given character
   digit from the given string number, resulting the decimal form is
   maximised.

Example 1

Input: $str = "15456", $char = "5"
Output: "1546"

Removing the second "5" is better because the digit following it (6) is
greater than 5. In the first case, 5 was followed by 4 (a decrease),
which makes the resulting number smaller.

Example 2

Input: $str = "7332", $char = "3"
Output: "732"

Example 3

Input: $str = "2231", $char = "2"
Output: "231"

Removing either "2" results in the same string here. By removing a "2",
we allow the "3" to move up into a higher decimal place.

Example 4

Input: $str = "543251", $char = "5"
Output: "54321"

If we remove the first "5", the number starts with 4. If we remove the
second "5", the number still starts with 5. Keeping the largest possible
digit in the highest place value is almost always the priority.

Example 5

Input: $str = "1921", $char = "1"
Output: "921"

Task 2: Big and Little Omega
"""
### solution by pokgopun@gmail.com

def mib(string: str, char: str) -> str:
    idx = -1
    l = len(string)
    i = l
    while True:
        i = string.rfind(char, 0, i)
        if i == -1:
            break
        if idx == -1 or string[i] < string[i+1]:
            idx = i
    if idx == -1:
        return string
    return "".join(string[i] for i in range(l) if i != idx)

import unittest

class TestMib(unittest.TestCase):
    def test(self):
        for (string, char), otpt in {
                ("15456", "5"): "1546",
                ("7332", "3"): "732",
                ("2231", "2"): "231",
                ("543251", "5"): "54321",
                ("1921", "1"): "921",
                }.items():
            self.assertEqual(mib(string, char), otpt)

unittest.main()
