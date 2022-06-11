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

def cuban1(mx):
  o=[]
  ps=set(genprimes(mx))
  for y in range(1,mx+1):
    q=3*y*(y+1)+1
    if q > mx:
      break
    if q in ps:
      o.append(q)
  return o

class TestCuban1(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(cuban1(1000),
                           [7, 19, 37, 61, 127, 271, 331, 397, 547,
                            631, 919],'example 1')

unittest.main()
