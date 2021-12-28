#! /usr/bin/python3

import unittest

def dotproduct(a,b):
  p=0
  for i,v in enumerate(a):
    p+=v*b[i]
  return p

class TestDotproduct(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(dotproduct([1,2,3],[4,5,6]),32,'example 1')

unittest.main()
