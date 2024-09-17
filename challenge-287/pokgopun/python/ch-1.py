### https://theweeklychallenge.org/blog/perl-weekly-challenge-287/
"""

Task 1: Strong Password

Submitted by: [42]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a string, $str.

   Write a program to return the minimum number of steps required to make
   the given string very strong password. If it is already strong then
   return 0.

   Criteria:
- It must have at least 6 characters.
- It must contains at least one lowercase letter, at least one upper case letter
 and at least one digit.
- It shouldn't contain 3 repeating characters in a row.

   Following can be considered as one step:
- Insert one character
- Delete one character
- Replace one character with another

Example 1

Input: $str = "a"
Output: 5

Example 2

Input: $str = "aB2"
Output: 3

Example 3

Input: $str = "PaaSW0rd"
Output: 0

Example 4

Input: $str = "Paaasw0rd"
Output: 1

Example 5

Input: $str = "aaaaa"
Output: 2

Task 2: Valid Number
"""
### solution by pokgopun@gmail.com

def strongPassword(passwd: str):
    cRpt = 0
    prev,crpt = "", 0
    hasDgt,hasUc,hasLc = False, False, False
    for c in passwd:
        if ord(c) >= 48 and ord(c) <= 57:
            hasDgt = True
        if ord(c) >= 65 and ord(c) <= 90:
            hasUc = True
        if ord(c) >= 97 and ord(c) <= 122:
            hasLc = True
        if prev == c:
            crpt += 1
            if crpt==3:
                cRpt += 1
                crpt = 0
                prev = ""
        else:
            prev = c
            crpt = 1
    cHas = 0
    for lgc in (hasDgt,hasUc,hasLc):
        if lgc == False:
            cHas += 1
    mChr = 6 - min(6,len(passwd))
    #print(mChr,cHas,cRpt)
    return max(mChr, cHas, cRpt)

import unittest

class TestStringPassword(unittest.TestCase):
    def test(self):
        for inpt, otpt in {
                "a": 5,
                "aB2": 3,
                "PaaSW0rd": 0,
                "Paaasw0rd": 1,
                "aaaaa": 2,
                "aaaaaa": 2,
                "aaaaaaa": 2,
                "aaaaaaaa": 2,
                "aaaaaaaaa": 3,
                "aaaaaaaaaa": 3,
                "aaa": 3,
                "s3cret": 1,
                "444o333": 2,
                "44333": 2,
                }.items():
            #print(inpt,otpt)
            self.assertEqual(strongPassword(inpt),otpt)

unittest.main()
