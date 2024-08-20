#! /usr/bin/python3

from collections import defaultdict

def uniquenumber(a):
  c = defaultdict(lambda: 0)
  for n in a:
    c[n] += 1
  return [k for k in c.keys() if c[k] == 1][0]

import unittest

class TestUniquenumber(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(uniquenumber([3, 3, 1]), 1, 'example 1')

  def test_ex2(self):
    self.assertEqual(uniquenumber([3, 2, 4, 2, 4]), 3, 'example 2')

  def test_ex3(self):
    self.assertEqual(uniquenumber([1]), 1, 'example 3')

  def test_ex4(self):
    self.assertEqual(uniquenumber([4, 3, 1, 1, 1, 4]), 3, 'example 4')

unittest.main()
