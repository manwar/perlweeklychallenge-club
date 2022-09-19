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

def primepartition(n, divs):
  pl = genprimes(n)
  p = [[]]
  while len(p) > 0:
    pa = p.pop()
    if len(pa) == divs:
      if sum(pa) == n:
        return pa
    else:
      px = set(pa)
      for pq in pl:
        if pq not in px:
          pb = pa.copy()
          pb.append(pq)
          p.append(pb)
  return [n]

class TestPrimepartition(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(primepartition(18, 2),
                           [13, 5],'example 1')

        def test_ex2(self):
          self.assertEqual(primepartition(19, 3),
                           [11, 5, 3],'example 1')

unittest.main()
