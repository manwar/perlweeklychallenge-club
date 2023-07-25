#! /usr/bin/python3

from datetime import date

def friday13th(y):
  f = 0
  for m in range(1, 12+1):
    if date(y, m, 13).weekday() == 4:
      f += 1
  return f

import unittest

class TestFriday13th(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(friday13th(2023), 2, 'example 1')

unittest.main()
