#! /usr/bin/python3

def countevendigitsnumber(a):
  t = 0
  for p in a:
    even = False
    pt = p
    while pt >= 10:
      pt //= 10
      even = not even
    if even:
      t += 1
  return t

import unittest

class TestCountevendigitsnumber(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(countevendigitsnumber([10, 1, 111, 24, 1000]), 3, 'example 1')

  def test_ex2(self):
    self.assertEqual(countevendigitsnumber([111, 1, 11111]), 0, 'example 2')

  def test_ex3(self):
    self.assertEqual(countevendigitsnumber([2, 8, 1024, 256]), 1, 'example 3')

unittest.main()
