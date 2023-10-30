#! /usr/bin/python3

from collections import defaultdict

def commoncharacters(a):
  ac = []
  for w in a:
    h = defaultdict(lambda: 0)
    for c in w:
      h[c] += 1
    ac.append(h)
  vc = ac[0]
  for aa in ac[1:]:
    for c in list(vc.keys()):
      if c in aa:
        vc[c] = min(vc[c], aa[c])
      else:
        del vc[c]
  out = []
  for c in a[0]:
    if c in vc:
      out.append(c)
      vc[c] -= 1
      if vc[c] == 0:
        del vc[c]
  return out

import unittest

class TestCommoncharacters(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(commoncharacters(["java", "javascript", "julia"]), ["j", "a"], 'example 1')

  def test_ex2(self):
    self.assertEqual(commoncharacters(["bella", "label", "roller"]), ["e", "l", "l"], 'example 2')

  def test_ex3(self):
    self.assertEqual(commoncharacters(["cool", "lock", "cook"]), ["c", "o"], 'example 3')

unittest.main()
