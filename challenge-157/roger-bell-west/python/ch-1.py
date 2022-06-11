#! /usr/bin/python3

import unittest

from functools import reduce

def pythagoreanmeans(s):
  return {"AM": round(arithmeticmean(s),1),
          "GM": round(geometricmean(s),1),
          "HM": round(harmonicmean(s),1)}

def arithmeticmean(s):
  return reduce(lambda a, b: a + b, s) / len(s)

def geometricmean(s):
  return pow(reduce(lambda a, b: a * b, s),1/len(s))

def harmonicmean(s):
  return len(s)/reduce(lambda a, b: a + 1/b, s, 0)

class TestPythagoreanmeans(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(pythagoreanmeans([1,3,5,7,9]),
                           {"AM": 5.0, "GM": 3.9, "HM": 2.8},
                           'example 1')

        def test_ex2(self):
          self.assertEqual(pythagoreanmeans([2,4,6,8,10]),
                           {"AM": 6.0, "GM": 5.2, "HM": 4.4},
                           'example 2')

        def test_ex3(self):
          self.assertEqual(pythagoreanmeans([1,2,3,4,5]),
                           {"AM": 3.0, "GM": 2.6, "HM": 2.2},
                           'example 3')

unittest.main()
