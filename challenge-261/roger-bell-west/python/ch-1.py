#! /usr/bin/python3

def elementdigitsum(a):
  delta = 0
  for n0 in a:
    n = n0 // 10
    m = 10
    while n > 0:
      delta += (n % 10) * (m - 1)
      n //= 10
      m *= 10
  return delta

import unittest

class TestElementdigitsum(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(elementdigitsum([1, 2, 3, 45]), 36, 'example 1')

  def test_ex2(self):
    self.assertEqual(elementdigitsum([1, 12, 3]), 9, 'example 2')

  def test_ex3(self):
    self.assertEqual(elementdigitsum([1, 2, 3, 4]), 0, 'example 3')

  def test_ex4(self):
    self.assertEqual(elementdigitsum([236, 416, 336, 350]), 1296, 'example 4')

unittest.main()
