#! /usr/bin/python3

def productsign(a):
  out = 1
  for t in a:
    if t < 0:
      out = -out
    elif t == 0:
      out = 0
      break
  return out

import unittest

class TestProductsign(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(productsign([-1, -2, -3, -4, 3, 2, 1]), 1, 'example 1')

  def test_ex2(self):
    self.assertEqual(productsign([1, 2, 0, -2, -1]), 0, 'example 2')

  def test_ex3(self):
    self.assertEqual(productsign([-1, -1, 1, -1, 2]), -1, 'example 3')

unittest.main()
