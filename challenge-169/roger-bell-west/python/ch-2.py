#! /usr/bin/python3

import unittest

from math import sqrt,floor,gcd
from collections import deque
from functools import reduce

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

def achilles(ct):
  o = []
  n = 1
  while True:
    n += 1
    pv = [i for i in primefactor(n).values()]
    if len(pv) > 1 and min(pv) >= 2 and reduce(gcd,pv,pv[0]) == 1:
       o.append(n)
       if len(o) >= ct:
         break
  return o

class TestAchilles(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(achilles(20),
                           [72, 108, 200, 288, 392, 432, 500, 648,
                            675, 800, 864, 968, 972, 1125, 1152, 1323,
                            1352, 1372, 1568, 1800],
                           'example 1')

unittest.main()
