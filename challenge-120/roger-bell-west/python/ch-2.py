#! /usr/bin/python3

import unittest
import re

def ca(n):
  a=0.0
  p=re.compile(r"([0-9]+):([0-9]+)")
  m=p.match(n)
  hh=int(m.group(1))
  mm=int(m.group(2))
  ha=hh*30+mm/2.0
  ma=mm*6
  a=abs(ha-ma)
  while a > 180:
    a -= 360
  return abs(a)

class TestCa(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(ca('03:10'),35,'example 1')
          
        def test_ex2(self):
          self.assertEqual(ca('04:00'),120,'example 2')

unittest.main()
