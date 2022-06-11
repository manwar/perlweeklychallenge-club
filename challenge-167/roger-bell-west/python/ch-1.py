#! /usr/bin/python3

import unittest

from math import sqrt,floor
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

def cyclicpermute(n):
  ss = str(n)
  o = []
  for p in range(len(ss)):
    ss = ss[1:] + ss[0]
    o.append(int(ss))
  return o

def circular(mindigits,ct):
  o = []
  base = 1
  for p in range(mindigits-1):
    base = base * 10
  while len(o) < ct:
    pr = genprimes(base * 10)
    prs = set(pr)
    for cp in pr:
      if cp >= base:
        v = True
        cpp = cyclicpermute(cp)
        for cpc in cpp:
          if cpc not in prs:
            v = False
            break
        if v:
          o.append(cp)
          if len(o) >= ct:
            break
          for cpc in cpp:
            prs.discard(cpc)
    base = base * 10
  return o

class TestCircular(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(cyclicpermute(123),
                           [231,312,123],'example 1')

        def test_ex2(self):
          self.assertEqual(circular(3,10),
                           [113, 197, 199, 337, 1193, 3779, 11939,
                            19937, 193939, 199933],'example 2')

unittest.main()
