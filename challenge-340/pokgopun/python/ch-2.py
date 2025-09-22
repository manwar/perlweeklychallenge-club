### https://theweeklychallenge.org/blog/perl-weekly-challenge-340/
"""

Task 2: Ascending Numbers

Submitted by: [49]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a string, $str, is a list of tokens separated by a single
   space. Every token is either a positive number consisting of digits 0-9
   with no leading zeros, or a word consisting of lowercase English
   letters.

   Write a script to check if all the numbers in the given string are
   strictly increasing from left to right.

Example 1

Input: $str = "The cat has 3 kittens 7 toys 10 beds"
Output: true

Numbers 3, 7, 10 - strictly increasing.

Example 2

Input: $str = 'Alice bought 5 apples 2 oranges 9 bananas'
Output: false

Example 3

Input: $str = 'I ran 1 mile 2 days 3 weeks 4 months'
Output: true

Example 4

Input: $str = 'Bob has 10 cars 10 bikes'
Output: false

Example 5

Input: $str = 'Zero is 0 one is 1 two is 2'
Output: true
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 28th September
   2025.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
"""
### solution by pokgopun@gmail.com

import re

def an(string: str) -> bool:
    numbers = [ int(m.group(1)) for m in re.finditer(r'(\d+)',string) ]
    if len(numbers) < 2:
        return False
    n = numbers[0]
    for v in numbers[1:]:
        if n >= v:
            return False
        n = v
    return True

import unittest

class TestAn(unittest.TestCase):
    def test(self):
        for inpt, otpt in {
                "The cat has 3 kittens 7 toys 10 beds": True,
                'Alice bought 5 apples 2 oranges 9 bananas': False,
                'I ran 1 mile 2 days 3 weeks 4 months': True,
                'Bob has 10 cars 10 bikes': False,
                'Zero is 0 one is 1 two is 2': True,
                }.items():
            self.assertEqual(an(inpt), otpt)

unittest.main()
