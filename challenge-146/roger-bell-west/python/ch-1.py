#! /usr/bin/python3

import unittest

from math import sqrt,log,floor
from collections import deque

def genprimes(mx):
  primesh=set(range(2,4))
  for i in range(6,mx+1,6):
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

def nthprime(n):
  m=15
  if n >= 6:
    m=floor(1+n*log(n*log(n)))
  primes=genprimes(m)
  return primes[n-1]

class TestNthprime(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(nthprime(10001),104743,'example 1')

unittest.main()
