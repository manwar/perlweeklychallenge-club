#! /usr/bin/python3

def multiplybytwo(a, start):
  p = set(a)
  v = start
  while v in p:
    v *= 2
  return v

import unittest

class TestMultiplybytwo(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(multiplybytwo([5, 3, 6, 1, 12], 3), 24, 'example 1')

  def test_ex2(self):
    self.assertEqual(multiplybytwo([1, 2, 4, 3], 1), 8, 'example 2')

  def test_ex3(self):
    self.assertEqual(multiplybytwo([5, 6, 7], 2), 2, 'example 3')

unittest.main()
