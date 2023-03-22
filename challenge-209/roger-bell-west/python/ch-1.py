#! /usr/bin/python3

import unittest

def specialbitcharacters(a):
  s = 0
  for v in a:
    if s == 1:
      s = 2
    else:
      s = v
  return s == 0

class TestSpecialbitcharacters(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(specialbitcharacters([1, 0, 0]), True, 'example 1')

  def test_ex2(self):
    self.assertEqual(specialbitcharacters([1, 1, 1, 0]), False, 'example 2')

unittest.main()
