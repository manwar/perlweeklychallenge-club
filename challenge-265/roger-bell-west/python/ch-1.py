#! /usr/bin/python3

from collections import defaultdict
from math import floor

def thirtythreepercentappearance(a):
  m = defaultdict(lambda: 0);
  for n in a:
    m[n] += 1
  threshold = floor(len(a) * 33 / 100)
  if floor(threshold * 100 / 33) != len(a):
    threshold += 1
  s = [k for k in m.keys() if m[k] >= threshold]
  if len(s) > 0:
    return min(s)
  else:
    return -1

import unittest

class TestThirtythreepercentappearance(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(thirtythreepercentappearance([1, 2, 3, 3, 3, 4, 2]), 3, 'example 1')

  def test_ex2(self):
    self.assertEqual(thirtythreepercentappearance([1, 1]), 1, 'example 2')

  def test_ex3(self):
    self.assertEqual(thirtythreepercentappearance([1, 2, 3]), 1, 'example 3')

unittest.main()
