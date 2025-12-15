### https://theweeklychallenge.org/blog/perl-weekly-challenge-352/
"""

Task 1: Match String

Submitted by: [67]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of strings.

   Write a script to return all strings that are a substring of another
   word in the given array in the order they occur.

Example 1

Input: @words = ("cat", "cats", "dog", "dogcat", "dogcat", "rat", "ratcatdogcat"
)
Output: ("cat", "dog", "dogcat", "rat")

Example 2

Input: @words = ("hello", "hell", "world", "wor", "ellow", "elloworld")
Output: ("hell", "world", "wor", "ellow")

Example 3

Input: @words = ("a", "aa", "aaa", "aaaa")
Output: ("a", "aa", "aaa")

Example 4

Input: @words = ("flower", "flow", "flight", "fl", "fli", "ig", "ght")
Output: ("flow", "fl", "fli", "ig", "ght")

Example 5

Input: @words = ("car", "carpet", "carpenter", "pet", "enter", "pen", "pent")
Output: ("car", "pet", "enter", "pen", "pent")

Task 2: Binary Prefix
"""
### solution by pokgopun@gmail.com

def ms(words: tuple[str]) -> tuple[str]:
    l = len(words)
    m = []
    for i in range(l):
        sub = words[i]
        for j in range(l):
            sup = words[j]
            if m.count(sub) == 0 and i != j and sup.find(sub) > -1:
                m.append(sub)
                break
    return tuple(m)

import unittest

class TestMs(unittest.TestCase):
    def test(self):
        for inpt, otpt in {
                ("cat", "cats", "dog", "dogcat", "dogcat", "rat", "ratcatdogcat"): ("cat", "dog", "dogcat", "rat"),
                ("hello", "hell", "world", "wor", "ellow", "elloworld"): ("hell", "world", "wor", "ellow"),
                ("a", "aa", "aaa", "aaaa"): ("a", "aa", "aaa"),
                ("flower", "flow", "flight", "fl", "fli", "ig", "ght"): ("flow", "fl", "fli", "ig", "ght"),
                ("car", "carpet", "carpenter", "pet", "enter", "pen", "pent"): ("car", "pet", "enter", "pen", "pent"),
                }.items():
            self.assertEqual(ms(inpt),otpt)

unittest.main()
