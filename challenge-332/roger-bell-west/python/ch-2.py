#! /usr/bin/python3

from collections import defaultdict

def oddletters(a):
  c = defaultdict(lambda: 0)
  for x in a:
    c[x] += 1
  return all(x % 2 == 1 for x in c.values())

import unittest

class TestOddletters(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(oddletters("weekly"), False, 'example 1')

  def test_ex2(self):
    self.assertEqual(oddletters("perl"), True, 'example 2')

  def test_ex3(self):
    self.assertEqual(oddletters("challenge"), False, 'example 3')

unittest.main()
