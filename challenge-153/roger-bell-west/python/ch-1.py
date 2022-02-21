#! /usr/bin/python3

import unittest

def leftfactorial(mx):
  out=[]
  fact=1
  sm=0
  for i in range(mx):
    if i > 0:
      fact *= i
    sm += fact
    out.append(sm)
  return out

class TestLeftfactorial(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(leftfactorial(10),[1, 2, 4, 10, 34, 154, 874, 5914, 46234, 409114],'example 1')

unittest.main()
