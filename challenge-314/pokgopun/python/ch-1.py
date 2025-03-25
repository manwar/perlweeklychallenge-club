### https://theweeklychallenge.org/blog/perl-weekly-challenge-314/
"""

Task 1: Equal Strings

Submitted by: [45]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given three strings.

   You are allowed to remove the rightmost character of a string to make
   all equals.

   Write a script to return the number of operations to make it equal
   otherwise -1.

Example 1

Input: $s1 = "abc", $s2 = "abb", $s3 = "ab"
Output: 2

Operation 1: Delete "c" from the string "abc"
Operation 2: Delete "b" from the string "abb"

Example 2

Input: $s1 = "ayz", $s2 = "cyz", $s3 = "xyz"
Output: -1

Example 3

Input: $s1 = "yza", $s2 = "yzb", $s3 = "yzc"
Output: 3

Task 2: Sort Column
"""
### solution by pokgopun@gmail.com

def es(s1: str, s2: str, s3: str) -> int:
    if s1 == s2 and s2 == s3: ### no operation required if all equal
        return 0
    sls = (len(s1),len(s2),len(s3)) ### lengths for all strings
    mn = min(sls) ### lenght of the shortest string, this is the longest equal chars possible
    sm = sum(sls) ### sum of lenghts, it will be deducted with 3 * equal chars to yeild number of delete operation
    if s1[:mn] == s2[:mn] and s2[:mn] == s3[:mn]: ### quick exit if the shortest string is the equal part
        return sm -3*mn 
    for i in range(mn):  ### check number of equal char up to length of the shortest string
        if s1[i] != s2[i] or s2[i] != s3[i]: ### exit when the #i char is not equal
            break
    if i == 0: ### no equal string possible as their 1st char is not even the same
        return -1
    return sm - 3*i

import unittest

class TestEs(unittest.TestCase):
    def test(self):
        for (s1, s2, s3), otpt in {
                ("abc", "abb", "ab"): 2,
                ("ayz", "cyz", "xyz"): -1,
                ("yza", "yzb", "yzc"): 3,
                ("abc", "abb", "a"): 4,
                ("", "abb", "a"): 4,
                ("", "", ""): 0,
                ("abcd", "abcd", "abcd"): 0,
                }.items():
            self.assertEqual(es(s1,s2,s3), otpt)

unittest.main()
