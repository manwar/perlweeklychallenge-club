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

def perrinprime(n):
  out = set()
  seq = deque([3, 0, 2])
  while True:
    nv = seq[0] + seq[1]
    seq.popleft()
    seq.append(nv)
    if isprime(nv):
      out.add(nv)
      if len(out) >= n:
        break
  o = list(out)
  o.sort()
  return o

class TestPerrinprime(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(perrinprime(13),
                           [2, 3, 5, 7, 17, 29, 277, 367, 853, 14197,
                            43721, 1442968193,
                            792606555396977],'example 1')

unittest.main()
