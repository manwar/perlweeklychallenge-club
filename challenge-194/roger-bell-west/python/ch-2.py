#! /usr/bin/python3

import unittest
from collections import defaultdict

def frequencyequalizer(s):
  f = defaultdict(lambda: 0)
  for c in s:
    f[c] += 1
  v = list(f.values())
  v.sort()
  if v[0] == v[-2] and v[0] + 1 == v[-1]:
    return True
  return False

class TestFrequencyEqualizer(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(frequencyequalizer("abbc"), True, 'example 1')

  def test_ex2(self):
    self.assertEqual(frequencyequalizer("xyzyyxz"), True, 'example 2')

  def test_ex3(self):
    self.assertEqual(frequencyequalizer("xzxz"), False, 'example 3')

unittest.main()
