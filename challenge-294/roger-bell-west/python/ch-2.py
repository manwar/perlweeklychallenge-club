#! /usr/bin/python3

from itertools import permutations

def nextpermutation(a):
  b = a.copy()
  b.sort()
  flag = False
  out = []
  for px in permutations(b):
    if len(out) == 0:
      out = px
    if flag:
      out = px
      break
    if list(px) == a:
      flag = True
  return list(out)

import unittest

class TestNextpermutation(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(nextpermutation([1, 2, 3]), [1, 3, 2], 'example 1')

  def test_ex2(self):
    self.assertEqual(nextpermutation([2, 1, 3]), [2, 3, 1], 'example 2')

  def test_ex3(self):
    self.assertEqual(nextpermutation([3, 1, 2]), [3, 2, 1], 'example 3')

unittest.main()
