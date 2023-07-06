#! /usr/bin/python3

import unittest

from math import sqrt,floor
from collections import deque

def genprimes(mx):
  primesh=set(range(2,min(mx+1,4)))
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

def countprimes(l):
  return len(genprimes(l))

class TestCountprimes(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(countprimes(10), 4, 'example 1')

  def test_ex2(self):
    self.assertEqual(countprimes(1), 0, 'example 2')

  def test_ex3(self):
    self.assertEqual(countprimes(20), 8, 'example 3')

unittest.main()
