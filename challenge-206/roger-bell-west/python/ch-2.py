#! /usr/bin/python3

import unittest
from itertools import permutations, combinations

def arraypairing(n):
  nl = len(n)
  if nl % 2 == 1:
    return 0
  hl = nl // 2
  out = []
  for px in combinations(range(nl), hl):
    pa = [n[i] for i in px]
    ps = set(px)
    pb = [n[i] for i in range(nl) if i not in ps]
    for pp in permutations(pa):
      s = 0
      for i in range(hl):
        s += min(pp[i], pb[i])
      out.append(s)
  return max(out)
  
class TestArraypairing(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(arraypairing([1, 2, 3, 4]), 4, 'example 1')

  def test_ex2(self):
    self.assertEqual(arraypairing([0, 2, 1, 3]), 2, 'example 2')

unittest.main()
