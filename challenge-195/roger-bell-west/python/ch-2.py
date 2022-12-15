#! /usr/bin/python3

import unittest
from collections import defaultdict

def mostfrequenteven(l):
  f = defaultdict(lambda: 0)
  for n in l:
    if n % 2 == 0:
      f[n] += 1
  if len(f) > 0:
    m = max(f.values())
    l = [i for i in f.keys() if f[i] == m]
    l.sort()
    return l[0]
  else:
    return -1

class TestMostfrequenteven(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(mostfrequenteven([1, 1, 2, 6, 2]), 2, 'example 1')

  def test_ex2(self):
    self.assertEqual(mostfrequenteven([1, 3, 5, 7]), -1, 'example 2')

  def test_ex3(self):
    self.assertEqual(mostfrequenteven([6, 4, 4, 6, 1]), 4, 'example 3')

unittest.main()
