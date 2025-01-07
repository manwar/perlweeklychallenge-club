#! /usr/bin/python3

from itertools import permutations

def concatenate(a):
  return int("".join([str(x) for x in a]))

def threedigitseven(a):
  s = set()
  for d in range(1, 4):
    for px in permutations(a, d):
      c = concatenate(px)
      if c >= 100 and c <= 999 and c % 2 == 0:
        s.add(c)
  out = list(s)
  out.sort()
  return out

import unittest

class TestThreedigitseven(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(threedigitseven([2, 1, 3, 0]), [102, 120, 130, 132, 210, 230, 302, 310, 312, 320], 'example 1')

  def test_ex2(self):
    self.assertEqual(threedigitseven([2, 2, 8, 8, 2]), [222, 228, 282, 288, 822, 828, 882], 'example 2')

unittest.main()
