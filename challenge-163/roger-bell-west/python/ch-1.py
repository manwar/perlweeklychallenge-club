#! /usr/bin/python3

import unittest

from itertools import combinations

def summer(a,b):
  return a+b

def sumbitwise(ls):
  s = 0
  for c in combinations(ls,2):
    s += c[0] & c[1]
  return s

class TestSumbitwise(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(sumbitwise([1,2,3]),
                           3,
                           'example 1')

        def test_ex2(self):
          self.assertEqual(sumbitwise([2,3,4]),
                           2,
                           'example 2')

unittest.main()
