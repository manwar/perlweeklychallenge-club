#! /usr/bin/python3

def peakpoint(a):
  h = 0
  o = 0
  for p in a:
    h += p
    o = max(o, h)
  return o

import unittest

class TestPeakpoint(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(peakpoint([-5, 1, 5, -9, 2]), 1, 'example 1')

  def test_ex2(self):
    self.assertEqual(peakpoint([10, 10, 10, -25]), 30, 'example 2')

  def test_ex3(self):
    self.assertEqual(peakpoint([3, -4, 2, 5, -6, 1]), 6, 'example 3')

  def test_ex4(self):
    self.assertEqual(peakpoint([-1, -2, -3, -4]), 0, 'example 4')

  def test_ex5(self):
    self.assertEqual(peakpoint([-10, 15, 5]), 10, 'example 5')

unittest.main()
