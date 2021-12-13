#! /usr/bin/python3

import unittest

from math import sqrt

def factorpairs(n):
  if n==1:
    return [2]
  ff=[]
  s=int(sqrt(n))
  if s*s==n:
    ff.append(s*2)
    s-=1
  for pf in range(2,s+1):
    if n % pf == 0:
      ff.append(pf+int(n/pf))
  ff.append(n+1)
  return ff

def is_stealthy(n):
  p=factorpairs(n)
  if len(p)==1:
    return False
  for ix in range(len(p)-1):
    for iy in range(ix+1,len(p)):
      if abs(p[ix]-p[iy])==1:
        return True
  return False

class TestIs_Stealthy(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(is_stealthy(36),True,'example 1')

        def test_ex2(self):
          self.assertEqual(is_stealthy(12),True,'example 2')

        def test_ex3(self):
          self.assertEqual(is_stealthy(6),False,'example 3')

unittest.main()
