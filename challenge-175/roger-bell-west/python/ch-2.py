#! /usr/bin/python3

import unittest

from math import gcd

def eulertotient(n):
  return sum(1 for k in range(1,n+1) if gcd(n,k) == 1)

def iteratedtotient(n0):
  p = 0
  n = n0
  while True:
    n = eulertotient(n)
    p += n
    if n == 1:
      break
    if p > n0:
      break
  return p  

def perfecttotient(ct):
  o = []
  n = 1
  while len(o) < ct:
    n += 1
    if iteratedtotient(n) == n:
      o.append(n)
  return o

class TestPerfectTotient(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(perfecttotient(20),
                           [3, 9, 15, 27, 39, 81, 111, 183, 243, 255,
                            327, 363, 471, 729, 2187, 2199, 3063, 4359,
                            4375, 5571],
                           'example 1')
 
unittest.main()
