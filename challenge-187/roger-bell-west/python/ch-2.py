#! /usr/bin/python3

import unittest

from itertools import combinations

def magicaltriplets(a):
  out = []
  mv = 0
  for b in combinations(a, 3):
    if b[0] + b[1] > b[2] and b[1] + b[2] > b[0] and b[0] + b[2] > b[1]:
       v = sum(b)
       if v > mv:
         mv = v
         out = b
  return list(reversed(sorted(out)))

class TestMagicaltriplets(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(magicaltriplets([1, 2, 3, 2]),
                           [3, 2, 2],
                           'example 1')

        def test_ex2(self):
          self.assertEqual(magicaltriplets([1, 3, 2]),
                           [],
                           'example 2')

        def test_ex3(self):
          self.assertEqual(magicaltriplets([1, 1, 2, 3]),
                           [],
                           'example 3')

        def test_ex4(self):
          self.assertEqual(magicaltriplets([2, 4, 3]),
                           [4, 3, 2],
                           'example 4')

unittest.main()
