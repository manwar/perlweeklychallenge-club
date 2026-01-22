#! /usr/bin/python3

from math import gcd

def uniquefractiongenerator(a):
  den = 1
  for dn in range(2, a + 1):
    den *= dn
  f = set()
  for d in range(1, a + 1):
    nd = den // d
    for n in range(1, a + 1):
      f.add(n * nd)
  out = []
  ff = list(f)
  ff.sort()
  for n in ff:
    g = gcd(n, den)
    nn = n // g
    nd = den // g
    out.append(str(nn) + "/" + str(nd))
  return out

import unittest

class TestUniquefractiongenerator(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(uniquefractiongenerator(3), ["1/3", "1/2", "2/3", "1/1", "3/2", "2/1", "3/1"], 'example 1')

  def test_ex2(self):
    self.assertEqual(uniquefractiongenerator(4), ["1/4", "1/3", "1/2", "2/3", "3/4", "1/1", "4/3", "3/2", "2/1", "3/1", "4/1"], 'example 2')

  def test_ex3(self):
    self.assertEqual(uniquefractiongenerator(1), ["1/1"], 'example 3')

  def test_ex4(self):
    self.assertEqual(uniquefractiongenerator(6), ["1/6", "1/5", "1/4", "1/3", "2/5", "1/2", "3/5", "2/3", "3/4", "4/5", "5/6", "1/1", "6/5", "5/4", "4/3", "3/2", "5/3", "2/1", "5/2", "3/1", "4/1", "5/1", "6/1"], 'example 4')

  def test_ex5(self):
    self.assertEqual(uniquefractiongenerator(5), ["1/5", "1/4", "1/3", "2/5", "1/2", "3/5", "2/3", "3/4", "4/5", "1/1", "5/4", "4/3", "3/2", "5/3", "2/1", "5/2", "3/1", "4/1", "5/1"], 'example 5')

unittest.main()
