### https://theweeklychallenge.org/blog/perl-weekly-challenge-367/
"""

Task 2: Conflict Events

Submitted by: [62]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given two events start and end time.

   Write a script to find out if there is a conflict between the two
   events. A conflict happens when two events have some non-empty
   intersection.

Example 1

Input: @event1 = ("10:00", "12:00")
       @event2 = ("11:00", "13:00")
Output: true

Both events overlap from "11:00" to "12:00".

Example 2

Input: @event1 = ("09:00", "10:30")
       @event2 = ("10:30", "12:00")
Output: false

Event1 ends exactly at 10:30 when Event2 starts.
Since the problem defines intersection as non-empty, exact boundaries touching i
s not a conflict.

Example 3

Input: @event1 = ("14:00", "15:30")
       @event2 = ("14:30", "16:00")
Output: true

Both events overlap from 14:30 to 15:30.

Example 4

Input: @event1 = ("08:00", "09:00")
       @event2 = ("09:01", "10:00")
Output: false

There is a 1-minute gap from "09:00" to "09:01".

Example 5

Input: @event1 = ("23:30", "00:30")
       @event2 = ("00:00", "01:00")
Output: true

They overlap from "00:00" to "00:30".
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 5th April 2026.
"""
### solution by pokgopun@gmail.com

def t2e(string: str) -> int:
    return int(string[:2]) * 60  + int(string[3:])

def ce(e1: tuple[str], e2: tuple[str]) -> bool:
    e1a, e1b, e2a, e2b = t2e(e1[0]), t2e(e1[1]), t2e(e2[0]), t2e(e2[1])
    c = 24 * 60
    if e1a > e1b:
        e1a -= c
    if e2a > e2b:
        e2a -= c
    return not ((e2a <= e1a or e2a >= e1b) and (e2b <= e1a or e2b >= e1b))

import unittest

class TestCe(unittest.TestCase):
    def test(self):
        for (e1, e2), otpt in {
                (("10:00", "12:00") , ("11:00", "13:00")): True ,
                (("09:00", "10:30") , ("10:30", "12:00")): False ,
                (("14:00", "15:30") , ("14:30", "16:00")): True ,
                (("08:00", "09:00") , ("09:01", "10:00")): False ,
                (("23:30", "00:30") , ("00:00", "01:00")): True ,
                }.items():
            self.assertEqual(ce(e1, e2), otpt)

unittest.main()
