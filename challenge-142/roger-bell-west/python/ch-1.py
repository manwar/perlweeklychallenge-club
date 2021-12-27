#! /usr/bin/python3

import unittest

from math import sqrt
from collections import deque

def factor(n):
  if n==1:
    return [1]
  ff=deque()
  s=int(sqrt(n))
  if s*s==n:
    ff.append(s)
    s-=1
  for pf in range(2,s+1):
    if n % pf == 0:
      ff.appendleft(pf)
      ff.append(int(n/pf))
  ff.appendleft(1)
  ff.append(n)
  return ff

def dld(m,n):
  return len([i for i in factor(m) if i % 10 == n])

class TestDld(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(dld(24,2),2,'example 1')

        def test_ex2(self):
          self.assertEqual(dld(30,5),2,'example 2')

unittest.main()
