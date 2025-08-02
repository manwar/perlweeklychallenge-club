#! /usr/bin/python3

def sortcolumn(a):
  vv = []
  for i, s in enumerate(a):
    for j,c in enumerate(s):
      if i == 0:
        vv.append([])
      vv[j].append(c)
  tot = 0
  for x in vv:
    y = x.copy()
    y.sort()
    for i, xx in enumerate(x):
      if y[i] != xx:
        tot += 1
        break
  return tot

import unittest

class TestSortcolumn(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(sortcolumn(["swpc", "tyad", "azbe"]), 2, 'example 1')

  def test_ex2(self):
    self.assertEqual(sortcolumn(["cba", "daf", "ghi"]), 1, 'example 2')

  def test_ex3(self):
    self.assertEqual(sortcolumn(["a", "b", "c"]), 0, 'example 3')

unittest.main()
