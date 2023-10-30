#! /usr/bin/python3

from collections import defaultdict

def similarwords(a):
  ct = defaultdict(lambda: 0)
  ac = ord('a')
  for w in a:
    hs = set(w)
    mask = 0
    for c in hs:
      mask |= 1 << (ord(c) - ac)
    ct[mask] += 1
  pairs = 0
  for cv in ct.values():
    if cv > 1:
      pairs += cv * (cv - 1) / 2
  return pairs

import unittest

class TestSimilarwords(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(similarwords(["aba", "aabb", "abcd", "bac", "aabc"]), 2, 'example 1')

  def test_ex2(self):
    self.assertEqual(similarwords(["aabb", "ab", "ba"]), 3, 'example 2')

  def test_ex3(self):
    self.assertEqual(similarwords(["nba", "cba", "dba"]), 0, 'example 3')

unittest.main()
