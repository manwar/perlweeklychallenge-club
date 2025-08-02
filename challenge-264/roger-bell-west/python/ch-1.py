#! /usr/bin/python3

from collections import defaultdict

def greatestenglishletter(a):
  m = defaultdict(lambda: 0)
  for c in a:
    uc = c.upper()
    flag = 2
    if c == uc:
      flag = 1
    m[uc] |= flag
  s = [k for k in m.keys () if m[k] == 3]
  if len(s) > 0:
    s.sort()
    return s[-1]
  else:
    return ""

import unittest

class TestGreatestenglishletter(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(greatestenglishletter("PeRlwEeKLy"), "L", 'example 1')

  def test_ex2(self):
    self.assertEqual(greatestenglishletter("ChaLlenge"), "L", 'example 2')

  def test_ex3(self):
    self.assertEqual(greatestenglishletter("The"), "", 'example 3')

unittest.main()
