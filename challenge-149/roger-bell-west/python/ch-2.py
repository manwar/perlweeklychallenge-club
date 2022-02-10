#! /usr/bin/python3

import unittest

from math import sqrt,floor

def ls(base):
  max=0
  for i in reversed(range(base+1)):
    max *= base
    max += i
  digits="0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"
  t=floor(sqrt(max))
  while True:
    s=t*t
    v=True
    c=[0 for i in range(base)]
    dg=""
    while s > 0:
      d=s % base
      c[d] += 1
      if c[d] > 1:
        v=False
        break
      s //= base
      dg=digits[d] + dg
    if v:
      return dg
    t -= 1

class TestLs(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(ls(2),"1",'example 1')

        def test_ex2(self):
          self.assertEqual(ls(4),"3201",'example 2')

        def test_ex3(self):
          self.assertEqual(ls(10),"9814072356",'example 3')

        def test_ex4(self):
          self.assertEqual(ls(12),"B8750A649321",'example 4')

unittest.main()
