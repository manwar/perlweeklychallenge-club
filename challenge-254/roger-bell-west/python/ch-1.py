#! /usr/bin/python3

def threepower(n0):
  if n0 == 0:
    return False
  n = abs(n0)
  lo = 1
  hi = int(n / 2)
  while True:
    t = int((lo + hi) / 2)
    c = t * t * t
    if c == n:
      return True
    if lo == t:
      return False
    if c < n:
      lo = t
    else:
      hi = t

import unittest

class TestThreepower(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(threepower(27), True, 'example 1')

  def test_ex2(self):
    self.assertEqual(threepower(0), False, 'example 2')

  def test_ex3(self):
    self.assertEqual(threepower(6), False, 'example 3')

unittest.main()
