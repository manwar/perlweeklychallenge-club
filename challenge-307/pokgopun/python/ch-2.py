### https://theweeklychallenge.org/blog/perl-weekly-challenge-307/
"""

Task 2: Find Anagrams

Submitted by: [43]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a list of words, @words.

   Write a script to find any two consecutive words and if they are
   anagrams, drop the first word and keep the second. You continue this
   until there is no more anagrams in the given list and return the count
   of final list.

Example 1

Input: @words = ("acca", "dog", "god", "perl", "repl")
Output: 3

Step 1: "dog" and "god" are anagrams, so dropping "dog" and keeping "god" => ("a
cca", "god", "perl", "repl")
Step 2: "perl" and "repl" are anagrams, so dropping "perl" and keeping "repl" =>
 ("acca", "god", "repl")

Example 2

Input: @words = ("abba", "baba", "aabb", "ab", "ab")
Output: 2

Step 1: "abba" and "baba" are anagrams, so dropping "abba" and keeping "baba" =>
 ("baba", "aabb", "ab", "ab")
Step 2: "baba" and "aabb" are anagrams, so dropping "baba" and keeping "aabb" =>
 ("aabb", "ab", "ab")
Step 3: "ab" and "ab" are anagrams, so dropping "ab" and keeping "ab" => ("aabb"
, "ab")
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 9^th February
   2025.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
"""
### solution by pokgopun@gmail.com

from typing import Tuple

def findAnagrams(words: Tuple[str]) -> Tuple[str]:
    words = list(words)
    i = 0
    while True:
        if i + 1 >= len(words):
            break
        cur,nxt = words[i], words[i+1]
        if len(cur) == len(nxt) and set(cur) == set(nxt):
            words.pop(i)
        else:
            i += 1
    #print(words)
    return len(words)

import unittest

class TestFindAnagrams(unittest.TestCase):
    def test(self):
        for inpt, otpt in {
                ("acca", "dog", "god", "perl", "repl"): 3,
                ("abba", "baba", "aabb", "ab", "ab"): 2,
                }.items():
            self.assertEqual(findAnagrams(inpt), otpt)

unittest.main()


