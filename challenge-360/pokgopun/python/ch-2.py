### https://theweeklychallenge.org/blog/perl-weekly-challenge-360/
"""

Task 2: Word Sorter

Submitted by: [47]Mohammad Sajid Anwar
     __________________________________________________________________

   You are give a sentence.

   Write a script to order words in the given sentence alphabetically but
   keeps the words themselves unchanged.

Example 1

Input: $str = "The quick brown fox"
Output: "brown fox quick The"

Example 2

Input: $str = "Hello    World!   How   are you?"
Output: "are Hello How World! you?"

Example 3

Input: $str = "Hello"
Output: "Hello"

Example 4

Input: $str = "Hello, World! How are you?"
Output: "are Hello, How World! you?"

Example 5

Input: $str = "I have 2 apples and 3 bananas!"
Output: "2 3 and apples bananas! have I"
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 14th February
   2026.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
"""
### solution by pokgopun@gmail.com

def wordSorter(string: str) -> str:
    words = [ e for e in string.split(" ") if len(e) > 0 ]
    words.sort(key = lambda x: x.lower())
    return " ".join(words)


import unittest

class TestWordSorter(unittest.TestCase):
    def test(self):
        for inpt, otpt in {
                "The quick brown fox" : "brown fox quick The",
                "Hello    World!   How   are you?" : "are Hello How World! you?",
                "Hello" : "Hello",
                "Hello, World! How are you?" : "are Hello, How World! you?",
                "I have 2 apples and 3 bananas!" : "2 3 and apples bananas! have I",
                }.items():
            self.assertEqual(wordSorter(inpt), otpt)

unittest.main()
