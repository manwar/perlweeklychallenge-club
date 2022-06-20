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

def nthprimelimit(n):
  m=15
  if n >= 6:
    m=floor(1+n*log(n*log(n)))
  return m

def primorial(ct):
  o = [1]
  for p in genprimes(nthprimelimit(ct-1)):
    o.append(o[-1] * p)
    if len(o) >= ct:
      break
  return o

class TestPrimorial(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(primorial(5),
                           [1, 2, 6, 30, 210],'example 1')

        def test_ex2(self):
          self.assertEqual(primorial(10),
                           [1, 2, 6, 30, 210, 2310, 30030, 510510,
                            9699690, 223092870],'example 1')

unittest.main()
