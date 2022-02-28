#! /usr/bin/python3

import unittest
from math import sqrt

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

def padovanprimes(ct):
  pp=set()
  padovans=[1,1,1,1]
  while True:
    padovans[3]=padovans[0]+padovans[1]
    for i in range(3):
      padovans[i]=padovans[i+1]
    if isprime(padovans[3]):
      pp.add(padovans[3])
      if len(pp) >= ct:
        break
  out=list(pp)
  out.sort()
  return out

class TestPadovanPrimes(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(padovanprimes(10),
                           [2, 3, 5, 7, 37, 151, 3329, 23833,
                            13091204281, 3093215881333057],
                           'example 1')

unittest.main()
