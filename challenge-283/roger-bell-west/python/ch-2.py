#! /usr/bin/python3

from collections import defaultdict

def digitcountvalue(a):
  c = defaultdict(lambda: 0)
  for n in a:
    c[n] += 1
  for ix in range(len(a)):
    if a[ix] != c[ix]:
        return False;
  return True

import unittest

class TestDigitcountvalue(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(digitcountvalue([1, 2, 1, 0]), True, 'example 1')

  def test_ex2(self):
    self.assertEqual(digitcountvalue([0, 3, 0]), False, 'example 2')

unittest.main()
