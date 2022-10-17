#! /usr/bin/python3

import unittest

from datetime import date, timedelta
import re

def s2date(ds):
  dm = re.findall(r"\d+", ds)
  if len(dm) == 2:
    return date(2022, int(dm[1]), int(dm[0]))

def daystogether(a, b):
  starts = sorted([s2date(a[0]), s2date(b[0])])
  ends = sorted([s2date(a[1]), s2date(b[1])])
  if ends[0] >= starts[1]:
    return (ends[0]-starts[1]).days+1
  else:
    return 0

class TestDaystogether(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(daystogether(["12-01", "20-01"], ["15-01", "18-01"]),
                           4,
                           'example 1')

        def test_ex2(self):
          self.assertEqual(daystogether(["02-03", "12-03"], ["13-03", "14-03"]),
                           0,
                           'example 2')

        def test_ex3(self):
          self.assertEqual(daystogether(["02-03", "12-03"], ["11-03", "15-03"]),
                           2,
                           'example 3')

        def test_ex4(self):
          self.assertEqual(daystogether(["30-03", "05-04"], ["28-03", "02-04"]),
                           4,
                           'example 4')

unittest.main()
