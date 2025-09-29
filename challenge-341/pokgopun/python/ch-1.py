### https://theweeklychallenge.org/blog/perl-weekly-challenge-341/
"""

Task 1: Broken Keyboard

Submitted by: [39]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a string containing English letters only and also you are
   given broken keys.

   Write a script to return the total words in the given sentence can be
   typed completely.

Example 1

Input: $str = 'Hello World', @keys = ('d')
Output: 1

With broken key 'd', we can only type the word 'Hello'.

Example 2

Input: $str = 'apple banana cherry', @keys = ('a', 'e')
Output: 0

Example 3

Input: $str = 'Coding is fun', @keys = ()
Output: 3

No keys broken.

Example 4

Input: $str = 'The Weekly Challenge', @keys = ('a','b')
Output: 2

Example 5

Input: $str = 'Perl and Python', @keys = ('p')
Output: 1

Task 2: Reverse Prefix
"""
### solution by pokgopun@gmail.com

def bk(string: str, keys: tuple[str]) -> int:
    cnt = 0
    string = string.lower()
    for w in string.split(" "):
        for k in keys:
            #print(w,k)
            if w.find(k) != -1:
                break
        else:
            cnt += 1
    return cnt

def bk0(string: str, keys: tuple[str]) -> int:
    keys = set(keys)
    return sum( 1 if keys.intersection(set(e.lower())) == set() else 0 for e in string.split(" ") )

import unittest

class TestBk(unittest.TestCase):
    def test(self):
        for (string, keys), otpt in {
                ('Hello World', ('d')): 1,
                ('apple banana cherry', ('a', 'e')): 0,
                ('Coding is fun', ()): 3,
                ('The Weekly Challenge', ('a','b')): 2,
                ('Perl and Python', ('p')): 1,
                }.items():
            #print(string,keys)
            self.assertEqual(bk(string,keys),otpt)

unittest.main()
