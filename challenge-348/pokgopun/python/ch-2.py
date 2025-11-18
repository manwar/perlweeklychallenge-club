### https://theweeklychallenge.org/blog/perl-weekly-challenge-348/
"""

Task 2: Covert Time

Submitted by: [50]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given two strings, $source and $target, containing time in
   24-hour time form.

   Write a script to convert the source into target by performing one of
   the following operations:
1. Add  1 minute
2. Add  5 minutes
3. Add 15 minutes
4. Add 60 minutes

   Find the total operations needed to get to the target.

Example 1

Input: $source = "02:30"
       $target = "02:45"
Output: 1

Just one operation i.e. "Add 15 minutes".

Example 2

Input: $source = "11:55"
       $target = "12:15"
Output: 2

Two operations i.e. "Add 15 minutes" followed by "Add 5 minutes".

Example 3

Input: $source = "09:00"
       $target = "13:00"
Output: 4

Four operations of "Add 60 minutes".

Example 4

Input: $source = "23:45"
       $target = "00:30"
Output: 3

Three operations of "Add 15 minutes".

Example 5

Input: $source = "14:20"
       $target = "15:25"
Output: 2

Two operations, one "Add 60 minutes" and one "Add 5 minutes"
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 23rd November
   2025.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
"""
### solution by pokgopun@gmail.com

from datetime import datetime

def ct(source: str, target: str) -> int:
    #print(source,target)
    timefmt = "%H:%M"
    s = datetime.strptime(source, timefmt)
    t = datetime.strptime(target, timefmt)
    d = (t - s)
    m = d.total_seconds()/60
    if m < 0:
        m += 24*60
    #print(m)
    c = 0
    for dmn in (60,15,5):
        c += m // dmn
        m %= dmn
    return c + m

import unittest

class TestCt(unittest.TestCase):
    def test(self):
        for (source, target), otpt in {
                ("02:30", "02:45"): 1,
                ("11:55", "12:15"): 2,
                ("09:00", "13:00"): 4,
                ("23:45", "00:30"): 3,
                ("14:20", "15:25"): 2,
                }.items():
            self.assertEqual(ct(source,target),otpt)

unittest.main()
