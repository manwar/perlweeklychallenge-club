### https://theweeklychallenge.org/blog/perl-weekly-challenge-331/
"""

Task 2: Buddy Strings

Submitted by: [44]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given two strings, source and target.

   Write a script to find out if the given strings are Buddy Strings.
If swapping of a letter in one string make them same as the other then they are
`Buddy Strings`.

Example 1

Input: $source = "fuck"
       $target = "fcuk"
Output: true

The swapping of 'u' with 'c' makes it buddy strings.

Example 2

Input: $source = "love"
       $target = "love"
Output: false

Example 3

Input: $source = "fodo"
       $target = "food"
Output: true

Example 4

Input: $source = "feed"
       $target = "feed"
Output: true
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 27th July 2025.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
"""
### solution by pokgopun@gmail.com

def bs(s: str, t: str) -> bool:
    l = len(s)
    if l != len(t):
        return False
    if s == t:
        if l != len(set(s)):
            return True
        else:
            return False
    lst: list[str] = []
    for i in range(l):
        a, b = s[i], t[i]
        if a != b:
            lst.append(a)
            lst.append(b)
        if len(lst) == 4:
            if lst[0] == lst[3] and lst[1] == lst[2]:
                return s[i+1:] == t[i+1:]
    return False

import unittest

class TestBs(unittest.TestCase):
    def test(self):
        for (source, target), otpt in {
                ("fuck", "fcuk"): True,
                ("love", "love"): False,
                ("fodo", "food"): True,
                ("feed", "feed"): True,
                }.items():
            self.assertEqual(bs(source,target),otpt)

unittest.main()
