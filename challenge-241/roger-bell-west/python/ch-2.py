#! /usr/bin/python3

from collections import deque
from functools import reduce

def isqrt(s:int):
  if s <= 1:
    return s
  x0 = s // 2
  x1 = (x0 + s // x0) // 2
  while x1 < x0:
    x0 = x1
    x1 = (x0 + s // x0) // 2
  return x0

def genprimes(mx):
  primesh=set(range(2,4))
  for i in range(6,mx+2,6):
    for j in range(i-1,i+2,2):
      if j <= mx:
        primesh.add(j)
  q=deque([2,3,5,7])
  p=q.popleft()
  mr=isqrt(mx)
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
  for p in genprimes(isqrt(n)):
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

def primefactorcount(n):
  return reduce(lambda a, b: a + b, primefactor(n).values())


def primeorder(ints):
  c = dict((x, primefactorcount(x)) for x in ints)
  b = ints
  b.sort()
  b.sort(key = lambda i: c[i])
  return b

import unittest

class TestPrimeorder(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(primeorder([11, 8, 27, 4]), [11, 4, 8, 27], 'example 1')

unittest.main()
