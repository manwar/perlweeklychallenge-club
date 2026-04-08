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

def omega(a, mode):
  pf = primefactor(a)
  if mode == 0:
    return len(pf)
  else:
    return reduce(lambda a, b: a + b, pf.values())

import unittest

class TestOmega(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(omega(100061, 0), 3, 'example 1')

  def test_ex2(self):
    self.assertEqual(omega(971088, 0), 3, 'example 2')

  def test_ex3(self):
    self.assertEqual(omega(63640, 1), 6, 'example 3')

  def test_ex4(self):
    self.assertEqual(omega(988841, 1), 2, 'example 4')

  def test_ex5(self):
    self.assertEqual(omega(211529, 0), 2, 'example 5')

unittest.main()
