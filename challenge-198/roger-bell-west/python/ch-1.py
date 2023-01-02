#! /usr/bin/python3

import unittest
from itertools import tee

def maxgap(l0):
  if len(l0) < 2:
    return 0
  l = l0
  l.sort()
  q = []
  j, k = tee(l)
  next(k, None)
  for i in zip(j, k):
    q.append(i[1] - i[0])
  qm = max(q)
  return len([i for i in q if i == qm])

class TestMaxgap(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(maxgap([2, 5, 8, 1]), 2, 'example 1')

  def test_ex2(self):
    self.assertEqual(maxgap([3]), 0, 'example 2')

unittest.main()
