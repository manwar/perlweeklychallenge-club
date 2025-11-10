### https://theweeklychallenge.org/blog/perl-weekly-challenge-346/
"""

Task 1: Longest Parenthesis

Submitted by: [44]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a string containing only ( and ).

   Write a script to find the length of the longest valid parenthesis.

Example 1

Input: $str = '(()())'
Output: 6

Valid Parenthesis: '(()())'

Example 2

Input: $str = ')()())'
Output: 4

Valid Parenthesis: '()()' at positions 1-4.

Example 3

Input: $str = '((()))()(((()'
Output: 8

Valid Parenthesis: '((()))()' at positions 0-7.

Example 4

Input: $str = '))))((()('
Output: 2

Valid Parenthesis: '()' at positions 6-7.

Example 5

Input: $str = '()(()'
Output: 2

Valid Parenthesis: '()' at positions 0-1 and 3-4.

Task 2: Magic Expression
"""
### solution by pokgopun@gmail.com

def lp(string: str) -> int:
    string = list(string)
    mx = 0
    c = 0
    #print(string)
    for i in range(len(string)):
        #print(string[:i+1])
        if string[i] == '(':
            c += 1
        else:
            c -= 1
            if c < 0:
                c = 0
            else:
                j = i
                string[j] = ''
                while string[j] != '(':
                    j -= 1
                string[j] = ''
                while string[j] == '':
                    j -= 1
                    if j < 0:
                        break
                d = i - j
                if mx < d:
                    mx = d
    #print(string)
    return mx

import unittest

class TestLp(unittest.TestCase):
    def test(self):
        for inpt, otpt in {
                '(()())': 6,
                ')()())': 4,
                '((()))()(((()': 8,
                '))))((()(': 2,
                '()(()': 2,
                '((()(()()': 4,
                '((()(()())': 8,
                '()(()()': 4,
                '()(()())': 8,
                }.items():
            #print(f'input={inpt}, output={otpt}')
            self.assertEqual(lp(inpt),otpt)

unittest.main()
