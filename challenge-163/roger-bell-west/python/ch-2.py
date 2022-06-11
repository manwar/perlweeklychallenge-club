#! /usr/bin/python3

import unittest

from functools import reduce

def summer(a,b):
  return a+b

def summation(ls0):
  ls = ls0
  while len(ls) > 1:
    lv = []
    for i in range(1,len(ls)):
      lv.append(reduce(summer,(ls[n] for n in range(1,i+1)),0))
    ls = lv
  return ls[0]

class TestSummation(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(summation([1,2,3,4,5]),
                           42,
                           'example 1')

        def test_ex2(self):
          self.assertEqual(summation([1,3,5,7,9]),
                           70,
                           'example 2')

unittest.main()
