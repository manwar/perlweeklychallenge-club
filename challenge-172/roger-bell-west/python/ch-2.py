#! /usr/bin/python3

import unittest

def fivenumber(n0):
  n = n0.copy()
  n.sort()
  nl = len(n) - 1
  o = [ n[0] ]
  for quartile in range(1,4):
    bx = quartile * nl
    base = bx // 4
    v = n[base]
    if bx % 4 != 0:
      v = (n[base] + n[base+1]) / 2.0
    o.append(v)
  o.append(n[-1])
  return o

class TestPrimepartition(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(fivenumber([0.0, 0.0, 1.0, 2.0, 63.0, 61.0, 27.0, 13.0]),
                           [0.0, 0.5, 7.5, 44.0, 63.0],'example 1')

unittest.main()
