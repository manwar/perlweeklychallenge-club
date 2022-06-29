#! /usr/bin/python3

import unittest

from math import sqrt

def abundant(n):
  if n==1:
    return False
  ff = 1
  s = int(sqrt(n))
  if s * s == n:
    ff += s
    s -= 1
  for pf in range(2,s+1):
    if n % pf == 0:
      ff += pf
      ff += n // pf
      if ff > n:
        return True
  return False

def oddabundant(ct):
  n = 1
  o = []
  while True:
    if abundant(n):
      o.append(n)
      if len(o) >= ct:
        break
    n += 2
  return o

class TestOddAbundant(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(oddabundant(20),
                           [945, 1575, 2205, 2835, 3465, 4095, 4725,
                            5355, 5775, 5985, 6435, 6615, 6825, 7245,
                            7425, 7875, 8085, 8415, 8505,
                            8925],'example 1')

unittest.main()
