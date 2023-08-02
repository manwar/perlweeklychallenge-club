#! /usr/bin/python3

from collections import defaultdict

def uniquesum(a):
  c = defaultdict(lambda: 0)
  for n in a:
    c[n] += 1
  return sum([k for k, v in c.items() if v == 1])

import unittest

class TestUniquesum(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(uniquesum([2, 1, 3, 2]), 4, 'example 1')

  def test_ex2(self):
    self.assertEqual(uniquesum([1, 1, 1, 1]), 0, 'example 2')

  def test_ex3(self):
    self.assertEqual(uniquesum([2, 1, 3, 4]), 10, 'example 3')

unittest.main()
