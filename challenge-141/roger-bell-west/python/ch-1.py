#! /usr/bin/python3

import unittest

from math import sqrt

def factorcount(n):
  if n==1:
    return 1
  f=2
  s=int(sqrt(n))
  if s*s==n:
    s-=1
    f+=1
  for pf in range(2,s+1):
    if n % pf == 0:
      f += 2
  return f

def divisors(count,n):
  nn=n
  a=[]
  t=0
  while nn:
    t+=1
    if factorcount(t)==count:
      a.append(t)
      nn-=1
  return a

class TestDivisors(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(divisors(8,10),[24,30,40,42,54,56,66,70,78,88],'example 2')

unittest.main()
