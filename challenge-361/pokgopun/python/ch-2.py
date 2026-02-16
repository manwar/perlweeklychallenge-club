### https://theweeklychallenge.org/blog/perl-weekly-challenge-361/
"""

Task 2: Find Celebrity

Submitted by: [46]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a binary matrix (m x n).

   Write a script to find the celebrity, return -1 when none found.

     A celebrity is someone, everyone knows and knows nobody.

Example 1

Input: @party = (
            [0, 0, 0, 0, 1, 0],  # 0 knows 4
            [0, 0, 0, 0, 1, 0],  # 1 knows 4
            [0, 0, 0, 0, 1, 0],  # 2 knows 4
            [0, 0, 0, 0, 1, 0],  # 3 knows 4
            [0, 0, 0, 0, 0, 0],  # 4 knows NOBODY
            [0, 0, 0, 0, 1, 0],  # 5 knows 4
       );
Output: 4

Example 2

Input: @party = (
            [0, 1, 0, 0],  # 0 knows 1
            [0, 0, 1, 0],  # 1 knows 2
            [0, 0, 0, 1],  # 2 knows 3
            [1, 0, 0, 0]   # 3 knows 0
       );
Output: -1

Example 3

Input: @party = (
            [0, 0, 0, 0, 0],  # 0 knows NOBODY
            [1, 0, 0, 0, 0],  # 1 knows 0
            [1, 0, 0, 0, 0],  # 2 knows 0
            [1, 0, 0, 0, 0],  # 3 knows 0
            [1, 0, 0, 0, 0]   # 4 knows 0
       );
Output: 0

Example 4

Input: @party = (
            [0, 1, 0, 1, 0, 1],  # 0 knows 1, 3, 5
            [1, 0, 1, 1, 0, 0],  # 1 knows 0, 2, 3
            [0, 0, 0, 1, 1, 0],  # 2 knows 3, 4
            [0, 0, 0, 0, 0, 0],  # 3 knows NOBODY
            [0, 1, 0, 1, 0, 0],  # 4 knows 1, 3
            [1, 0, 1, 1, 0, 0]   # 5 knows 0, 2, 3
       );
Output: 3

Example 5

Input: @party = (
            [0, 1, 1, 0],  # 0 knows 1 and 2
            [1, 0, 1, 0],  # 1 knows 0 and 2
            [0, 0, 0, 0],  # 2 knows NOBODY
            [0, 0, 0, 0]   # 3 knows NOBODY
       );
Output: -1

Example 6

Input: @party = (
            [0, 0, 1, 1],  # 0 knows 2 and 3
            [1, 0, 0, 0],  # 1 knows 0
            [1, 1, 0, 1],  # 2 knows 0, 1 and 3
            [1, 1, 0, 0]   # 3 knows 0 and 1
      );
Output: -1
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 22nd February
   2026.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
"""
### solution by pokgopun@gmail.com

def celeb(party: tuple[tuple[int]]) -> int:
    l = len(party)
    knowns = [0 for e in range(l)]
    cid = -1
    for r in range(l):
        knows = 0
        for c in range(l):
            k = party[r][c]
            knows += k
            knowns[c] += k
        if knows == 0 and knowns[r] == r:
            cid = r
    if cid >= 0 and knowns[cid] != l - 1:
        cid = -1
    return cid

import unittest

class TestCeleb(unittest.TestCase):
    def test(self):
        for inpt, otpt in {
                (
            (0, 0, 0, 0, 1, 0),  # 0 knows 4
            (0, 0, 0, 0, 1, 0),  # 1 knows 4
            (0, 0, 0, 0, 1, 0),  # 2 knows 4
            (0, 0, 0, 0, 1, 0),  # 3 knows 4
            (0, 0, 0, 0, 0, 0),  # 4 knows NOBODY
            (0, 0, 0, 0, 1, 0),  # 5 knows 4
       ) : 4 ,
                (
            (0, 1, 0, 0),  # 0 knows 1
            (0, 0, 1, 0),  # 1 knows 2
            (0, 0, 0, 1),  # 2 knows 3
            (1, 0, 0, 0),  # 3 knows 0
       ) : -1 ,
                (
            (0, 0, 0, 0, 0),  # 0 knows NOBODY
            (1, 0, 0, 0, 0),  # 1 knows 0
            (1, 0, 0, 0, 0),  # 2 knows 0
            (1, 0, 0, 0, 0),  # 3 knows 0
            (1, 0, 0, 0, 0),  # 4 knows 0
       ) : 0 ,
                (
            (0, 1, 0, 1, 0, 1),  # 0 knows 1, 3, 5
            (1, 0, 1, 1, 0, 0),  # 1 knows 0, 2, 3
            (0, 0, 0, 1, 1, 0),  # 2 knows 3, 4
            (0, 0, 0, 0, 0, 0),  # 3 knows NOBODY
            (0, 1, 0, 1, 0, 0),  # 4 knows 1, 3
            (1, 0, 1, 1, 0, 0),  # 5 knows 0, 2, 3
       ) : 3 ,
                (
            (0, 1, 1, 0),  # 0 knows 1 and 2
            (1, 0, 1, 0),  # 1 knows 0 and 2
            (0, 0, 0, 0),  # 2 knows NOBODY
            (0, 0, 0, 0),  # 3 knows NOBODY
       ) : -1 ,
                (
            (0, 0, 1, 1),  # 0 knows 2 and 3
            (1, 0, 0, 0),  # 1 knows 0
            (1, 1, 0, 1),  # 2 knows 0, 1 and 3
            (1, 1, 0, 0),  # 3 knows 0 and 1
      ) : -1 ,
                }.items():
            self.assertEqual(celeb(inpt), otpt)

unittest.main()
