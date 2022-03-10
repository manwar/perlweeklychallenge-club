#! /usr/bin/python3

import unittest

from math import sqrt,floor,log
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

def isprime(candidate):
  if candidate==2:
    return True
  elif candidate==3:
    return True
  elif candidate % 2 == 0:
    return False
  elif candidate % 3 == 0:
    return False
  anchor = 0
  limit = int(sqrt(candidate))
  while True:
    anchor += 6
    for t in range(anchor-1,anchor+2,2):
      if t > limit:
        return True
      if candidate % t == 0:
        return False

def nthprimelimit(n):
  m=15
  if n >= 6:
    m=floor(1+n*log(n*log(n)))
  return m

def fortunate(ct):
  n=ct*2
  primes=genprimes(nthprimelimit(n))
  o=set()
  ll=[]
  ph=1
  for p in primes:
    ph *= p
    if len(o) >= ct:
      if p >= max(o):
        break
    l=p+1
    while not isprime(l+ph):
      l += 1
    o.add(l)
    if len(o) > ct:
      ll=list(o)
      ll.sort()
      ll=ll[0:ct]
      o=set(ll)
  return ll

class TestFortunate(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(fortunate(8),
                           [3, 5, 7, 13, 17, 19, 23, 37],'example 1')

unittest.main()
