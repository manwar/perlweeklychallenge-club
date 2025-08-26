#! /usr/bin/python3

from collections import defaultdict

def equalgroup(a):
  s = defaultdict(lambda: 0)
  for n in a:
    s[n] += 1
  v = sorted(list(set(s.values())))
  l = v[0]
  if l < 2:
    return False
  for t in range(2, l + 1):
    if all(c % t == 0 for c in v):
      return True
  return False

import unittest

class TestEqualgroup(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(equalgroup([1, 1, 2, 2, 2, 2]), True, 'example 1')

  def test_ex2(self):
    self.assertEqual(equalgroup([1, 1, 1, 2, 2, 2, 3, 3]), False, 'example 2')

  def test_ex3(self):
    self.assertEqual(equalgroup([5, 5, 5, 5, 5, 5, 7, 7, 7, 7, 7, 7]), True, 'example 3')

  def test_ex4(self):
    self.assertEqual(equalgroup([1, 2, 3, 4]), False, 'example 4')

  def test_ex5(self):
    self.assertEqual(equalgroup([8, 8, 9, 9, 10, 10, 11, 11]), True, 'example 5')

unittest.main()
