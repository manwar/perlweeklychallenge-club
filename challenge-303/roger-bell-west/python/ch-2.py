#! /usr/bin/python3

from collections import defaultdict

def deleteandearn(a):
  ct = defaultdict(lambda: 0)
  for x in a:
    ct[x] += 1
  mx = 0
  stack = []
  stack.append((ct, 0))
  while len(stack) > 0:
    c = stack.pop()
    if len(c[0]) == 0:
      mx = max([mx, c[1]])
    else:
      for d in c[0].keys():
        cc = c[0].copy()
        cc[d] -= 1
        if cc[d] == 0:
          del cc[d]
        if d - 1 in cc:
          del cc[d - 1]
        if d + 1 in cc:
          del cc[d + 1]
        stack.append((cc, c[1] + d))
  return mx

import unittest

class TestDeleteandearn(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(deleteandearn([3, 4, 2]), 6, 'example 1')

  def test_ex2(self):
    self.assertEqual(deleteandearn([2, 2, 3, 3, 3, 4]), 9, 'example 2')

unittest.main()
