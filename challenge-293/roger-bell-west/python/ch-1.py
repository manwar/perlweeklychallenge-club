#! /usr/bin/python3

from collections import defaultdict

def dvalue(a):
  if a[0] < a[1]:
    return a[0] * 64 + a[1]
  else:
    return a[1] * 64 + a[0]

def similardominoes(a):
  c = defaultdict(lambda: 0)
  for x in a:
    c[dvalue(x)] += 1
  t = 0
  for v in c.values():
    if v > 1:
      t += v
  return t

import unittest

class TestSimilardominoes(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(similardominoes([[1, 3], [3, 1], [2, 4], [6, 8]]), 2, 'example 1')

  def test_ex2(self):
    self.assertEqual(similardominoes([[1, 2], [2, 1], [1, 1], [1, 2], [2, 2]]), 3, 'example 2')

unittest.main()
