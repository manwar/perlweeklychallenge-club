#! /usr/bin/python3

def incrementdecrement(operations):
  p = 0
  for s in operations:
    if s[1] == "+":
      p += 1
    else:
      p -= 1
  return p

import unittest

class TestIncrementdecrement(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(incrementdecrement(["--x", "x++", "x++"]), 1, 'example 1')

  def test_ex2(self):
    self.assertEqual(incrementdecrement(["x++", "++x", "x++"]), 3, 'example 2')

  def test_ex3(self):
    self.assertEqual(incrementdecrement(["x++", "++x", "--x", "x--"]), 0, 'example 3')

unittest.main()
