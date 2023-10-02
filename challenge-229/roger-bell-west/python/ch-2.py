#! /usr/bin/python3

from collections import defaultdict

def twoofthree(a):
  ct = defaultdict(lambda: 0)
  for iv in a:
    for n in set(iv):
      ct[n] += 1
  out = list(k for k, v in ct.items() if v >= 2)
  out.sort()
  return out

import unittest

class TestTwoofthree(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(twoofthree([[1, 1, 2, 4], [2, 4], [4]]), [2, 4], 'example 1')

  def test_ex2(self):
    self.assertEqual(twoofthree([[4, 1], [2, 4], [1, 2]]), [1, 2, 4], 'example 2')

unittest.main()
