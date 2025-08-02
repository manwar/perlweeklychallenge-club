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

def strongPassword(pwd: str):
    requiredCharset = dict.fromkeys(("09","AZ","az"), True)
    countRequiredCharset = len(requiredCharset)
    #n = 0
    for c in pwd:
        #n += 1
        for charset in requiredCharset.keys():
            if requiredCharset[charset] and c >= charset[0] and c <= charset[1]:
                requiredCharset[charset] = False
                countRequiredCharset -= 1
                break
        if countRequiredCharset==0:
                break
    #print(n,"char(s) checked for required charsets")
    countConsecutiveChar = 0
    consecutiveCharLength = 3
    if len(pwd) >= consecutiveCharLength:
        prev = ""
        count = 0
        for c in pwd:
            #print(c,"<=>",prev)
            if prev == c:
                count += 1
                if count == consecutiveCharLength:
                    countConsecutiveChar += 1
                    prev = ""
            else:
                prev = c
                count = 1
    countRequiredAddition = 6 - min(6, len(pwd))
    #print(countRequiredAddition, countConsecutiveChar, countRequiredCharset)
    return max(countRequiredAddition, countConsecutiveChar, countRequiredCharset)

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
