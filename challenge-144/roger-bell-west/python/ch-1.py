#! /usr/bin/python3

import unittest

def semiprime(mx):
  mxx=int(mx/2)
  primesh=set(range(2,mxx+1))
  p=2
  while p*p <= mxx:
    if p in primesh:
      for i in range(p*p,mx+1,p):
        primesh.discard(i)
    if p==2:
      p -= 1
    p += 2
  primes=list(primesh)
  primes.sort()
  semiprimesh=set()
  for i in range(len(primes)):
    for j in range(i,len(primes)):
      t=primes[i]*primes[j]
      if t <= mx:
        semiprimesh.add(t)
      else:
        break
  semiprimes=list(semiprimesh)
  semiprimes.sort()
  return semiprimes

class TestSemiprime(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(semiprime(100),[4, 6, 9, 10, 14, 15, 21, 22, 25, 26, 33, 34, 35, 38, 39, 46, 49, 51, 55, 57, 58, 62, 65, 69, 74, 77, 82, 85, 86, 87, 91, 93, 94, 95],'example 1')

unittest.main()
