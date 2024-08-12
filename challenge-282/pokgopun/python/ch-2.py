### https://theweeklychallenge.org/blog/perl-weekly-challenge-282/
"""

Task 2: Changing Keys

Submitted by: [58]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an alphabetic string, $str, as typed by user.

   Write a script to find the number of times user had to change the key
   to type the given string. Changing key is defined as using a key
   different from the last used key. The shift and caps lock keys won’t be
   counted.

Example 1

Input: $str = 'pPeERrLl'
Ouput: 3

p -> P : 0 key change
P -> e : 1 key change
e -> E : 0 key change
E -> R : 1 key change
R -> r : 0 key change
r -> L : 1 key change
L -> l : 0 key change

Example 2

Input: $str = 'rRr'
Ouput: 0

Example 3

Input: $str = 'GoO'
Ouput: 1
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 18th August
   2024.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
"""
### solution by pokgopun@gmail.com

def ck(string: str):
    string = string.lower()
    count = 0
    for i in range(len(string)-1):
        if string[i]!=string[i+1]:
            count += 1
    return count

import unittest

class TestCk(unittest.TestCase):
    def test(self):
        for inpt, otpt in {
                'pPeERrLl': 3,
                'rRr': 0,
                'GoO': 1,
                }.items():
            self.assertEqual(ck(inpt),otpt)

unittest.main()
 
