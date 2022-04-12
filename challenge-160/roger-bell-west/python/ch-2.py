#! /usr/bin/python3

import unittest

from functools import reduce

def equilibriumindex(s):
  sm=sum(s)
  sa=0
  for i,v in enumerate(s):
    sa += v
    if sa == sm:
      return i
    sa += v
  return -1

class TestEquilibriumindex(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(equilibriumindex([1,3,5,7,9]),
                           3,
                           'example 1')

        def test_ex2(self):
          self.assertEqual(equilibriumindex([1,2,3,4,5]),
                           -1,
                           'example 2')

        def test_ex3(self):
          self.assertEqual(equilibriumindex([2,4,2]),
                           1,
                           'example 3')

unittest.main()
