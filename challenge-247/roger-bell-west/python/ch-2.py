#! /usr/bin/python3

from collections import defaultdict

def mostfrequentletterpair(s):
  f = defaultdict(lambda: 0)
  for i in range(len(s) - 1):
    pair = s[i] + s[i+1]
    f[pair] += 1
  m = max(f.values())
  l = [i for i in f.keys() if f[i] == m]
  l.sort()
  return l[0]

import unittest

class TestMostfrequentletterpair(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(mostfrequentletterpair("abcdbca"), "bc", 'example 1')

  def test_ex2(self):
    self.assertEqual(mostfrequentletterpair("cdeabeabfcdfabgcd"), "ab", 'example 2')

unittest.main()
