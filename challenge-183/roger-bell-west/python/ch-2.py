#! /usr/bin/python3

from datetime import date, timedelta

import unittest

def datedifference(d1s, d2s):
  d1 = date.fromisoformat(d1s)
  d2 = date.fromisoformat(d2s)
  if d1 > d2:
    t = d1
    d1 = d2
    d2 = t
  yd = d2.year - d1.year
  inter = date(d2.year, d1.month, d1.day)
  if d1.month > d2.month or (d1.month == d2.month and d1.day > d2.day):
    inter = date(d2.year-1, d1.month, d1.day)
    yd -= 1
  return [yd, (d2 - inter).days]

class TestDatedifference(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(datedifference('2019-02-10', '2022-11-01'),
                           [3, 264],
                           'example 1')

        def test_ex2(self):
          self.assertEqual(datedifference('2020-09-15', '2022-03-29'),
                           [1, 195],
                           'example 2')

unittest.main()
