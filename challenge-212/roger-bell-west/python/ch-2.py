#! /usr/bin/python3

import unittest

from collections import defaultdict

def rearrangegroups(lst, size):
  h = dict()
  for k in lst:
    if k in h:
      h[k] += 1
    else:
      h[k] = 1
  out = []
  while True:
    m = min(h.keys())
    res = list(range(m, m + size))
    for n in res:
      if n in h:
        p = h[n] - 1
        if p == 0:
          del h[n]
        else:
          h[n] = p
      else:
        return []
    out.append(res)
    if len(h) == 0:
      break
  return out

class TestRearrangegroups(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(rearrangegroups([1, 2, 3, 5, 1, 2, 7, 6, 3], 3), [[1, 2, 3], [1, 2, 3], [5, 6, 7]], 'example 1')

  def test_ex2(self):
    self.assertEqual(rearrangegroups([1, 2, 3], 2), [], 'example 2')

  def test_ex3(self):
    self.assertEqual(rearrangegroups([1, 5, 2, 6, 4, 7], 3), [], 'example 3')

unittest.main()
