#! /usr/bin/python3

import unittest

from math import sqrt

def divisors(n):
  ff=[1]
  if n==1:
    return ff
  s=int(sqrt(n))
  if s * s == n:
    ff.append(s)
    s -= 1
  for pf in range(2,s+1):
    if n % pf == 0:
      ff.append(pf)
      ff.append(n // pf)
  return ff

def is_weird(n):
  dd=divisors(n)
  if sum(dd) <= n:
    return False
  for mask in range(1,1 << len(dd)):
    ss=0
    for i,d in enumerate(dd):
      if (mask & 1<<i) > 0:
        ss += d
        if ss > n:
          break
      if ss==n:
        return False
  return True

class TestWeird(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(is_weird(12),False,'example 1')

        def test_ex2(self):
          self.assertEqual(is_weird(13),False,'example 2')

        def test_ex3(self):
          self.assertEqual(is_weird(70),True,'example 3')

unittest.main()
