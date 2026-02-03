#! /usr/bin/python3

def strvalue(a):
  try:
    n = int(a)
  except ValueError:
    n = len(a)
  return n

def maxstrvalue(a):
  return max(strvalue(x) for x in a)

import unittest

class TestMaxstrvalue(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(maxstrvalue(["123", "45", "6"]), 123, 'example 1')

  def test_ex2(self):
    self.assertEqual(maxstrvalue(["abc", "de", "fghi"]), 4, 'example 2')

  def test_ex3(self):
    self.assertEqual(maxstrvalue(["0012", "99", "a1b2c"]), 99, 'example 3')

  def test_ex4(self):
    self.assertEqual(maxstrvalue(["x", "10", "xyz", "007"]), 10, 'example 4')

  def test_ex5(self):
    self.assertEqual(maxstrvalue(["hello123", "2026", "perl"]), 2026, 'example 5')

unittest.main()
