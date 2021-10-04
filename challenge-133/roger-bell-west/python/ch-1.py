#! /usr/bin/python3

import unittest

def isqrt(n):
  k=n >> 1
  x=True
  while x:
    k1=(k+int(n/k)) >> 1
    if k1 >= k:
      x=0
    k=k1
  return k

class TestIsqrt(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(isqrt(10),3,'example 1')

        def test_ex2(self):
          self.assertEqual(isqrt(27),5,'example 2')

        def test_ex3(self):
          self.assertEqual(isqrt(85),9,'example 3')

        def test_ex4(self):
          self.assertEqual(isqrt(101),10,'example 4')

unittest.main()
