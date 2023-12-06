#! /usr/bin/python3

def linearrecurrencesecondorder(seq):
  a = seq[0:3]
  b = seq[1:4]
  c = seq[2:5]
  q = (b[2] * a[0] - b[0] * a[2]) // (b[1] * a[0] - b[0] * a[1])
  p = (a[2] - a[1] * q) // a[0]
  return p * a[0] + q * a[1] == a[2] and p * b[0] + q * b[1] == b[2] and p * c[0] + q * c[1] == c[2]

import unittest

class TestLinearrecurrencesecondorder(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(linearrecurrencesecondorder([1, 1, 2, 3, 5]), True, 'example 1')

  def test_ex2(self):
    self.assertEqual(linearrecurrencesecondorder([4, 2, 4, 5, 7]), False, 'example 2')

  def test_ex3(self):
    self.assertEqual(linearrecurrencesecondorder([4, 1, 2, -3, 8]), True, 'example 3')

unittest.main()
