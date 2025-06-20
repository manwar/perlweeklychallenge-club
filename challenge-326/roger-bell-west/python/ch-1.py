#! /usr/bin/python3

from datetime import datetime, timedelta

def dayoftheyear(a):
  return datetime.fromisoformat(a).timetuple()[7]

import unittest

class TestDayoftheyear(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(dayoftheyear("2025-02-02"), 33, 'example 1')

  def test_ex2(self):
    self.assertEqual(dayoftheyear("2025-04-10"), 100, 'example 2')

  def test_ex3(self):
    self.assertEqual(dayoftheyear("2025-09-07"), 250, 'example 3')

unittest.main()
