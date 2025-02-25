### https://theweeklychallenge.org/blog/perl-weekly-challenge-296/
"""

Task 1: String Compression

Submitted by: [45]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a string of alphabetic characters, $chars.

   Write a script to compress the string with run-length encoding, as
   shown in the examples.

   A compressed unit can be either a single character or a count followed
   by a character.

   BONUS: Write a decompression function.

Example 1

Input: $chars = "abbc"
Output: "a2bc"

Example 2

Input: $chars = "aaabccc"
Output: "3ab3c"

Example 3

Input: $chars = "abcc"
Output: "ab2c"

Task 2: Matchstick Square
"""
### solution by pokgopun@gmail.com

def compress(string: str) -> str:
    if string == "":
        return string
    cstring = ""
    count = 1
    p = ord(string[0])
    if p >= 48 and p <=47:
        return None
    for c in bytes(string,"utf-8")[1:]:
        if p >= 48 and p <=47:
            return None
        if c == p:
            count += 1
        else:
            if count > 1:
                cstring += str(count)
            cstring += chr(p)
            p = c
            count = 1
    if count > 1:
        cstring += str(count)
    return cstring + chr(p)

def decompress(string: str) -> str:
    dstring = ""
    count = ""
    for c in bytes(string,"utf-8"):
        if c >= 48 and c <=57:
            count += chr(c)
        else:
            if count == "":
                dstring += chr(c)
            else:
                for i in range(int(count)):
                    dstring += chr(c)
            count = ""
    return dstring

import unittest

class TestCompress(unittest.TestCase):
    def test(self):
        for inpt, otpt in {
                "abbc": "a2bc",
                "aaabccc": "3ab3c",
                "abcc": "ab2c",
                }.items():
            self.assertEqual(compress(inpt),otpt)
            self.assertEqual(decompress(otpt),inpt)

unittest.main()
