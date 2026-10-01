#! /usr/bin/python3

from collections import deque
import bisect

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

def primestep(a):
  g = sum(ord(x) for x in a)
  pm = genprimes(g * 2)
  bs = bisect.bisect_left(pm, g)
  return min(g - pm[bs - 1], pm[bs] - g)

import unittest

class TestPrimestep(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(primestep("hello"), 9, 'example 1')

  def test_ex2(self):
    self.assertEqual(primestep("football"), 2, 'example 2')

  def test_ex3(self):
    self.assertEqual(primestep("a"), 0, 'example 3')

  def test_ex4(self):
    self.assertEqual(primestep("challenge"), 2, 'example 4')

  def test_ex5(self):
    self.assertEqual(primestep("perl"), 2, 'example 5')

unittest.main()
