### https://theweeklychallenge.org/blog/perl-weekly-challenge-361/
"""

Task 1: Zeckendorf Representation

Submitted by: [45]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a positive integer (<= 100).

   Write a script to return Zeckendorf Representation of the given
   integer.

     Every positive integer can be uniquely represented as sum of
     non-consecutive Fibonacci numbers.

Example 1

Input: $int = 4
Output: 3,1

4 => 3 + 1 (non-consecutive fibonacci numbers)

Example 2

Input: $int = 12
Output: 8,3,1

12 => 8 + 3 + 1

Example 3

Input: $int = 20
Output: 13,5,2

20 => 13 + 5 + 2

Example 4

Input: $int = 96
Output: 89,5,2

96 => 89 + 5 + 2

Example 5

Input: $int = 100
Output: 89,8,3

100 => 89 + 8 + 3

Task 2: Find Celebrity
"""
### solution by pokgopun@gmail.com

def zkd(n: int) -> list[int]:
    if n <= 3:
        return [n]
    fib = [0, 1, 1, 2, 3]
    i = 4
    while fib[i] < n:
            fib.append(fib[i]+fib[i-1])
            i += 1
    s: list[int] = []
    while n > 0:
        v = fib[i]
        if v <= n:
            n -= v
            s.append(v)
        i -= 1
    return s

import unittest

class TestZkd(unittest.TestCase):
    def test(self):
        for inpt, otpt in {
                4 : [3,1],
                12 : [8,3,1],
                20 : [13,5,2],
                96 : [89,5,2],
                100: [89,8,3],
                }.items():
            self.assertEqual(zkd(inpt), otpt)

unittest.main()
