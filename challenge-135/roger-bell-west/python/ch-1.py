#! /usr/bin/python3

import unittest

def m3d(n):
  m=str(abs(n))
  l=len(m)
  if l<3:
    return "too short"
  if l%2 == 0:
    return "even number of digits"
  i=int(l/2)-1
  return m[i:i+3]

class TestM3d(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(m3d(1234567),'345','example 1')

        def test_ex2(self):
          self.assertEqual(m3d(-123),'123','example 2')

        def test_ex3(self):
          self.assertEqual(m3d(1),'too short','example 3')

        def test_ex4(self):
          self.assertEqual(m3d(1010),'even number of digits','example 4')

unittest.main()
