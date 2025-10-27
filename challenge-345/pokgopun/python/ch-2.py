### https://theweeklychallenge.org/blog/perl-weekly-challenge-345/
"""

Task 2: Last Visitor

Submitted by: [44]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an integer array @ints where each element is either a
   positive integer or -1.

   We process the array from left to right while maintaining two lists:
@seen: stores previously seen positive integers (newest at the front)
@ans: stores the answers for each -1

   Rules:
If $ints[i] is a positive number -> insert it at the front of @seen
If $ints[i] is -1:

   Let $x be how many -1s in a row we’ve seen before this one.

   If $x < len(@seen) -> append seen[x] to @ans

   Else -> append -1 to @ans

   At the end, return @ans.

Example 1

Input: @ints = (5, -1, -1)
Output: (5, -1)

@seen = (5)
First  -1: @ans = (5)
Second -1: @ans = (5, -1)

Example 2

Input: @ints = (3, 7, -1, -1, -1)
Output: (7, 3, -1)

@seen = (3, 7)
First  -1: @ans = (7)
Second -1: @ans = (7, 3)
Third  -1: @ans = (7, 3, -1)

Example 3

Input: @ints = (2, -1, 4, -1, -1)
Output: (2, 4, 2)

Example 4

Input: @ints = (10, 20, -1, 30, -1, -1)
Output: (20, 30, 20)

Example 5

Input: @ints = (-1, -1, 5, -1)
Output: (-1, -1, 5)
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 2nd November
   2025.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
"""
### solution by pokgopun@gmail.com

def lv(ints: tuple[int]) -> tuple[int]:
    seen = list()
    ans = list()
    x = 0
    for v in ints:
        if v == -1:
            if x < len(seen):
                ans.append(seen[x])
            else:
                ans.append(-1)
            x += 1
        else:
            x = 0
            seen.insert(0, v)
        #print(f'v => {v}, seen => {seen}, ans => {ans}, x = {x}')
    return tuple(ans)

import unittest

class TestLv(unittest.TestCase):
    def test(self):
        for inpt, otpt in {
                (5, -1, -1): (5, -1),
                (3, 7, -1, -1, -1): (7, 3, -1),
                (2, -1, 4, -1, -1): (2, 4, 2),
                (10, 20, -1, 30, -1, -1): (20, 30, 20),
                (-1, -1, 5, -1): (-1, -1, 5),
                }.items():
            self.assertEqual(lv(inpt), otpt)

unittest.main()
