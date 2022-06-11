#! /usr/bin/python3

import unittest

from math import floor

def cardano(ct):
  out=[]
  k=0
  cn=0
  while (True):
    a=3*k+2
    b2c=(k+1)*(k+1)*(8*k+5)
    b=0
    b2=0
    inc=1
    while (True):
      b += 1
      b2 += inc
      inc += 2
      if b2 > b2c:
        break
      if b2c % b2 == 0:
        out.append([a,b,b2c/b2])
        cn += 1
        if cn >= ct:
          break
    if cn >= ct:
      break
    k += 1
  return out

class TestCardano(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(cardano(5),[[2,1,5],[5,1,52],[5,2,13],[8,1,189],[8,3,21]],'example 1')

unittest.main()
