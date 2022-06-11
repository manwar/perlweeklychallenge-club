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

def isnumpal(c0):
  c = c0
  j = 0
  while c > 0:
    j = 10 * j + c % 10
    c //= 10
  return c0 == j

def primepal(pmax):
  return [i for i in genprimes(pmax) if isnumpal(i)]

class TestPrimepal(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(primepal(1000),
                           [2, 3, 5, 7, 11, 101, 131, 151, 181, 191,
                            313, 353, 373, 383, 727, 757, 787, 797,
                            919, 929],
                           'example 1')

unittest.main()
