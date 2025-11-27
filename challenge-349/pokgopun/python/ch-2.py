### https://theweeklychallenge.org/blog/perl-weekly-challenge-349/
"""

Task 2: Meeting Point

Submitted by: [48]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given instruction string made up of U (up), D (down), L (left)
   and R (right).

   Write a script to return true if following the instruction, you meet
   (0,0) at any point along the sequence.

Example 1

Input: $path = "ULD"
Output: false

(-1,1) <- (0,1)
   |        ^
   v        |
(-1,0)    (0,0)

Example 2

Input: $path = "ULDR"
Output: true

 (-1,1) <- (0,1)
    |        ^
    v        |
 (-1,0) -> (0,0)

Example 3

Input: $path = "UUURRRDDD"
Output: false

(0,3) -> (1,3) -> (2,3) -> (3,3)
  ^                          |
  |                          v
(0,2)                      (3,2)
  ^                          |
  |                          v
(0,1)                      (3,1)
  ^                          |
  |                          v
(0,0)                      (3,0)

Example 4

Input: $path = "UURRRDDLLL"
Output: true

(0,2) -> (1,2) -> (2,2) -> (3,2)
  ^                          |
  |                          v
(0,1)                      (3,1)
  ^                          |
  |                          v
(0,0) <- (1,0) <- (1,1) <- (3,0)

Example 5

Input: $path = "RRUULLDDRRUU"
Output: true

(0,2) <- (1,2) <- (2,2)
  |                 ^
  v                 |
(0,1)             (2,1)
  |                 ^
  v                 |
(0,0) -> (1,0) -> (2,1)
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 30th November
   2025.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
"""
### solution by pokgopun@gmail.com

def mp(string: str) -> bool:
    x, y = 0, 0
    for c in string:
        match c:
            case "U":
                y += 1
            case "D":
                y -= 1
            case "L":
                x -= 1
            case "R":
                x += 1
        if x == 0 and y == 0:
            return True
    return False

import unittest

class TestMp(unittest.TestCase):
    def test(self):
        for inpt, otpt in {
                "ULD": False,
                "ULDR": True,
                "UUURRRDDD": False,
                "UURRRDDLLL": True,
                "RRUULLDDRRUU": True,
                }.items():
            self.assertEqual(mp(inpt), otpt)

unittest.main()
