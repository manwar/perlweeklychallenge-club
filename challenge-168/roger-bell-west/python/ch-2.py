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

def homeprime(n0):
  n = n0
  while True:
    t = primefactor(n)
    tk = list(t.keys())
    tk.sort()
    if len(tk) == 1 and t[tk[0]] == 1:
      break
    ns = ""
    for d in tk:
      ds = str(d)
      for i in range(t[d]):
        ns += ds
    n = int(ns)
  return n

class TestHomeprime(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(homeprime(10),
                           773,
                           'example 1')

        def test_ex2(self):
          self.assertEqual(homeprime(16),
                           31636373,
                           'example 2')

unittest.main()
