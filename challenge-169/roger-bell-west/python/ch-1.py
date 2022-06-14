#! /usr/bin/python3

import unittest

from math import sqrt,floor,gcd
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

def brilliant(ct):
  base = 1
  out = set()
  while True:
    pl = [x for x in genprimes(base * 10) if x >= base]
    for ai in range(len(pl)):
      for bi in range(ai,len(pl)):
        out.add(pl[ai] * pl[bi])
    if len(out) >= ct:
      break
    base *= 10
  o = list(out)
  o.sort()
  return o[0:ct]

class TestBrilliant(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(brilliant(20),
                           [4, 6, 9, 10, 14, 15, 21, 25, 35, 49, 121,
                            143, 169, 187, 209, 221, 247, 253, 289,
                            299],
                           'example 1')

unittest.main()
