### https://theweeklychallenge.org/blog/perl-weekly-challenge-357/
"""

Task 2: Unique Fraction Generator

Submitted by: Yary
     __________________________________________________________________

   Given a positive integer N, generate all unique fractions you can
   create using integers from 1 to N and follow the rules below:
- Use numbers 1 through N only (no zero)
- Create fractions like numerator/denominator
- List them in ascending order (from smallest to largest)
- If two fractions have the same value (like 1/2 and 2/4),
  only show the one with the smallest numerator

Example 1

Input: $int = 3
Output: 1/3, 1/2, 2/3, 1/1, 3/2, 2/1, 3/1

Example 2

Input: $int = 4
Output: 1/4, 1/3, 1/2, 2/3, 3/4, 1/1, 4/3, 3/2, 2/1, 3/1, 4/1

Example 3

Input: $int = 1
Output: 1/1

Example 4

Input: $int = 6
Output: 1/6, 1/5, 1/4, 1/3, 2/5, 1/2, 3/5, 2/3, 3/4,
        4/5, 5/6, 1/1, 6/5, 5/4, 4/3, 3/2, 5/3, 2/1,
        5/2, 3/1, 4/1, 5/1, 6/1

Example 5

Input: $int = 5
Output: 1/5, 1/4, 1/3, 2/5, 1/2, 3/5, 2/3, 3/4, 4/5, 1/1,
        5/4, 4/3, 3/2, 5/3, 2/1, 5/2, 3/1, 4/1, 5/1
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 25th January
   2026.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
"""
### solution by pokgopun@gmail.com

class Fraction:
    def __init__(self, nmrt, dmnt):
        self.nmrt = nmrt
        self.dmnt = dmnt
        self.val = nmrt/dmnt
    def __str__(self):
        return f'{self.nmrt}/{self.dmnt}'

def ufc(n: int) -> str:
    seen = {}
    lst = []
    for nmrt in range(1,n+1):
        for dmnt in range(n,0,-1):
            f = Fraction(nmrt, dmnt)
            if not seen.get(f.val, False):
                seen[f.val] = True
                lst.append(f)
    lst.sort(key=lambda x: x.nmrt/x.dmnt)
    return ", ".join(e.__str__() for e in lst)

import unittest

class TestUfc(unittest.TestCase):
    def test(self):
        for inpt, otpt in {
                3: "1/3, 1/2, 2/3, 1/1, 3/2, 2/1, 3/1",
                4: "1/4, 1/3, 1/2, 2/3, 3/4, 1/1, 4/3, 3/2, 2/1, 3/1, 4/1",
                1: "1/1",
                6: "1/6, 1/5, 1/4, 1/3, 2/5, 1/2, 3/5, 2/3, 3/4, 4/5, 5/6, 1/1, 6/5, 5/4, 4/3, 3/2, 5/3, 2/1, 5/2, 3/1, 4/1, 5/1, 6/1",
                5: "1/5, 1/4, 1/3, 2/5, 1/2, 3/5, 2/3, 3/4, 4/5, 1/1, 5/4, 4/3, 3/2, 5/3, 2/1, 5/2, 3/1, 4/1, 5/1",
                }.items():
            self.assertEqual(ufc(inpt), otpt)

unittest.main()
