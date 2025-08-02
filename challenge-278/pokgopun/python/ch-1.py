### https://theweeklychallenge.org/blog/perl-weekly-challenge-278/
"""

Task 1: Sort String

Submitted by: [51]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a shuffle string, $str.

   Write a script to return the sorted string.

     A string is shuffled by appending word position to each word.

Example 1

Input: $str = "and2 Raku3 cousins5 Perl1 are4"
Output: "Perl and Raku are cousins"

Example 2

Input: $str = "guest6 Python1 most4 the3 popular5 is2 language7"
Output: "Python is the most popular guest language"

Example 3

Input: $str = "Challenge3 The1 Weekly2"
Output: "The Weekly Challenge"

Task 2: Reverse Word
"""
### solution by pokgopun@gmail.com

'''
def sortString(string: str):
    return " ".join(
            e[:-1] for e in sorted(
                string.split(), key=lambda x: x[-1]
                )
            )
'''

def rankWord(string: str):
    i = 0
    while string[i-1].isdigit():
        i -= 1
    return (int(string[i:]),string[:i])

def sortString(string: str):
    return " ".join(
            e[1] for e in sorted(
                rankWord(x) for x in string.split()
                )
            )

import unittest

class TestSortString(unittest.TestCase):
    def test(self):
        for inpt, otpt in {
                "and2 Raku3 cousins5 Perl1 are4": "Perl and Raku are cousins",
                "guest6 Python1 most4 the3 popular5 is2 language7": "Python is the most popular guest language",
                "Challenge3 The1 Weekly2": "The Weekly Challenge",
                }.items():
            self.assertEqual(sortString(inpt),otpt)

unittest.main()
