#! /usr/bin/python3

import unittest

from math import sqrt

def sos(n):
  t=0
  for i in str(n):
    ii=int(i)
    t+=ii*ii
  s=int(sqrt(t))
  if s*s == t:
    return 1
  return 0
    
class TestSos(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(sos(34),1,"example 1")
  
        def test_ex2(self):
          self.assertEqual(sos(50),1,"example 2")
  
        def test_ex3(self):
          self.assertEqual(sos(52),0,"example 3")

unittest.main()
