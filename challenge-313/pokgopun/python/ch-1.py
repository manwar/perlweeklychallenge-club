### https://theweeklychallenge.org/blog/perl-weekly-challenge-313/
"""

Task 1: Broken Keys

Submitted by: [43]Mohammad Sajid Anwar
     __________________________________________________________________

   You have a broken keyboard which sometimes type a character more than
   once.

   You are given a string and actual typed string.

   Write a script to find out if the actual typed string is meant for the
   given string.

Example 1

Input: $name = "perl", $typed = "perrrl"
Output: true

Here "r" is pressed 3 times instead of 1 time.

Example 2

Input: $name = "raku", $typed = "rrakuuuu"
Output: true

Example 3

Input: $name = "python", $typed = "perl"
Output: false

Example 4

Input: $name = "coffeescript", $typed = "cofffeescccript"
Output: true

Task 2: Reverse Letters
"""
### solution by pokgopun@gmail.com

from dataclasses import dataclass

@dataclass
class CharCount:
    char: str
    count: int

def seqCnt(string: str) -> list[CharCount]:
    l = len(string)
    if l == 0:
        return []
    sc = [CharCount(string[0],1)]
    for c in string[1:]:
        if c == sc[-1].char:
            sc[-1].count += 1
        else:
            sc.append(CharCount(c,1))
    return sc

def bk(name: str, typed: str) -> bool:
    name_sc = seqCnt(name)
    typed_sc = seqCnt(typed)
    #print("->",name_sc)
    #print("=>",typed_sc)
    l = len(typed_sc)
    if l != len(name_sc):
        return False
    for i in range(l):
        n = name_sc[i]
        t = typed_sc[i]
        if n.char != t.char or n.count > t.count:
            return False
    return True

import unittest

class TestBk(unittest.TestCase):
    def test(self):
        for (name, typed), otpt in {
                ("perl", "perrrl"): True,
                ("raku", "rrakuuuu"): True,
                ("python", "perl"): False,
                ("coffeescript", "cofffeescccript"): True,
                ("noob", "nob"): False,
                ("snow", "noow"): False,
                ("ten", "teens"): False,
                ("aha", "haa"): False,
                }.items():
            self.assertEqual(bk(name,typed),otpt)

unittest.main()
