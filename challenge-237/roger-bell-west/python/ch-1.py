#! /usr/bin/python3

from datetime import date, timedelta

def seizetheday(year, month, weekcount, dayofweek):
  dt = date(year, month, 1)
  wd = dt.weekday() + 1
  if wd != dayofweek:
      dt += timedelta(days = (dayofweek - wd + 7) % 7)
  if weekcount > 1:
      dt += timedelta(weeks = (weekcount - 1))
  if dt.month != month or dt.year != year:
      return 0
  return dt.day

import unittest

class TestSeizetheday(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(seizetheday(2024, 4, 3, 2), 16, 'example 1')

  def test_ex2(self):
    self.assertEqual(seizetheday(2025, 10, 2, 4), 9, 'example 2')

  def test_ex3(self):
    self.assertEqual(seizetheday(2026, 8, 5, 3), 0, 'example 3')

unittest.main()
