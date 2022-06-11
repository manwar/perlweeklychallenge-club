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

def primefactor(n):
  f=dict()
  m=n
  for p in genprimes(floor(sqrt(n))):
    while (m % p == 0):
      m //= p
      if p in f:
        f[p] += 1
      else:
        f[p] = 1
    if m==1:
      break
  if m > 1:
    if m in f:
      f[m] += 1
    else:
      f[m] = 1
  return f

def moebius(n):
  z=0
  for k,v in primefactor(n).items():
    if v > 1:
      return 0
    z += 1
  if z % 2 == 0:
    return 1
  return -1

class TestMoebius(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(moebius(5),
                           -1,
                           'example 1')

        def test_ex2(self):
          self.assertEqual(moebius(10),
                           1,
                           'example 2')

        def test_ex3(self):
          self.assertEqual(moebius(20),
                           0,
                           'example 3')

unittest.main()
