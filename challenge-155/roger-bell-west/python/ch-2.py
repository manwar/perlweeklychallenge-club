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
  for p in [2,3,5,7]:
    while (m % p == 0):
      m //= p
      if p in f:
        f[p] += 1
      else:
        f[p] = 1
  if m > 1:
    for p in genprimes(m):
      while (m % p == 0):
        m //= p
        if p in f:
          f[p] += 1
        else:
          f[p] = 1
      if m==1:
        break
  return f

def lcm(m,n):
  return m//gcd(m,n)*n


def pisano(n):
  a=1
  for k, v in primefactor(n).items():
    nn = k ** v
    t=1
    x=[1,1]
    while x[0] != 0 or x[1] != 1:
      t += 1
      x=[x[1], (x[0]+x[1]) % nn]
    a = lcm(a,t)
  return a

class TestPisano(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(pisano(3),8,'example 1')

        def test_ex2(self):
          self.assertEqual(pisano(6),24,'example 2')

unittest.main()
