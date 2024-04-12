### https://theweeklychallenge.org/blog/perl-weekly-challenge-264/
"""

Task 1: Greatest English Letter

Submitted by: [47]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a string, $str, made up of only alphabetic characters
   [a..zA..Z].

   Write a script to return the greatest english letter in the given
   string.

     A letter is greatest if it occurs as lower and upper case. Also
     letter ‘b’ is greater than ‘a’ if ‘b’ appears after ‘a’ in the
     English alphabet.

Example 1

Input: $str = 'PeRlwEeKLy'
Output: L

There are two letters E and L that appears as lower and upper.
The letter L appears after E, so the L is the greatest english letter.

Example 2

Input: $str = 'ChaLlenge'
Output: L

Example 3

Input: $str = 'The'
Output: ''

Task 2: Target Array
"""
### solution by pokgopun@gmail.com

def gel(word: str):
    word = "".join(set(word)).upper() + chr(0)*2
    c = max(e for e in set(word) if word.count(e) > 1)
    return "" if c==chr(0) else c

import unittest

class TestGel(unittest.TestCase):
    def test(self):
        for inpt,otpt in {
                'PeRLwEeKLy': "E",
                'PeRlwEeKLy': "L",
                'ChaLlenge': "L",
                'The': ''
                }.items():
            self.assertEqual(gel(inpt),otpt)

unittest.main()
