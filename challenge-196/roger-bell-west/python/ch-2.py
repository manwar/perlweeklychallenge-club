#! /usr/bin/python3

import unittest

def rangelist(l):
  o = []
  start = l[0]
  prev = start
  for v in l[1:]:
    if v != prev + 1:
      if prev > start:
        o.append([start, prev])
      start = v
    prev = v
  if prev > start:
    o.append([start, prev])
  return o

class TestRangelist(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(rangelist([1, 3, 4, 5, 7]), [[3, 5]], 'example 1')

  def test_ex2(self):
    self.assertEqual(rangelist([1, 2, 3, 6, 7, 9]), [[1, 3], [6, 7]], 'example 2')

  def test_ex3(self):
    self.assertEqual(rangelist([0, 1, 2, 4, 5, 6, 8, 9]), [[0, 2], [4, 6], [8, 9]], 'example 3')

unittest.main()
