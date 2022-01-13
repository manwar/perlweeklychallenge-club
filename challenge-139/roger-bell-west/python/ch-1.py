#! /usr/bin/python3

import unittest

from itertools import tee

def jortsort(a):
  j, k = tee(a)
  next(k,None)
  for i in zip(j,k):
    if i[0] > i[1]:
      return False
  return True

class TestJortsort(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(jortsort([1,2,3,4,5]),True,'example 1')

        def test_ex2(self):
          self.assertEqual(jortsort([1,3,2,4,5]),False,'example 2')

unittest.main()
