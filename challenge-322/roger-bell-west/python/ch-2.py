#! /usr/bin/python3

def rankarray(a):
  b = list(set(a))
  b.sort()
  c = dict()
  for i, n in enumerate(b):
    c[n] = i + 1
  out = []
  for v in a:
    out.append(c[v])
  return out

import unittest

class TestRankarray(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(rankarray([55, 22, 44, 33]), [4, 1, 3, 2], 'example 1')

  def test_ex2(self):
    self.assertEqual(rankarray([10, 10, 10]), [1, 1, 1], 'example 2')

  def test_ex3(self):
    self.assertEqual(rankarray([5, 1, 1, 4, 3]), [4, 1, 1, 3, 2], 'example 3')

unittest.main()
