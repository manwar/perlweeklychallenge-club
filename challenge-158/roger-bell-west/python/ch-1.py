#! /usr/bin/python3

import unittest

from math import sqrt,floor,log
from collections import deque

def genprimes(mx):
  primesh=set(range(2,4))
  for i in range(6,mx+2,6):
    for j in range(i-1,i+2,2):
      if j <= mx:
        primesh.add(j)
  q=deque([2,3,5,7])
  p=q.popleft()
  mr=floor(sqrt(mx))
  while p <= mr:
    if p in primesh:
      for i in range(p*p,mx+1,p):
        primesh.discard(i)
    if len(q) < 2:
      q.append(q[-1]+4)
      q.append(q[-1]+2)
    p=q.popleft()
  primes=list(primesh)
  primes.sort()
  return primes

def digitsum(x0):
  s=0
  x=x0
  while x > 0:
    s += x % 10
    x //= 10
  return s

def additiveprimes(mx):
  o=[]
  p=genprimes(mx)
  ps=set(p)
  for q in p:
    if digitsum(q) in ps:
      o.append(q)
  return o

class TestAdditiveprimes(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(additiveprimes(100),
                           [2, 3, 5, 7, 11, 23, 29, 41, 43, 47, 61,
                            67, 83, 89],'example 1')

unittest.main()
