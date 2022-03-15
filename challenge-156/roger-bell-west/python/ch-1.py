#! /usr/bin/python3

import unittest

from math import sqrt,floor,log
from collections import deque

def isprime(candidate):
  if candidate < 2:
    return False
  elif candidate==2:
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

def hammingweight(x0):
  x=x0
  count=0
  while x > 0:
    x &= x-1
    count += 1
  return count
    
def pernicious(n):
  out=[]
  c=1
  while True:
    if isprime(hammingweight(c)):
      out.append(c)
      if len(out) >= n:
        break
    c += 1
  return out

class TestPernicious(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(pernicious(10),
                           [3, 5, 6, 7, 9, 10, 11, 12, 13, 14],'example 1')

unittest.main()
