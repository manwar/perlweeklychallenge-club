#! /usr/bin/python3

def sortbyonebits(a):
  c = dict()
  for i in a:
    c[i] = i.bit_count()
  b = a
  b.sort()
  b.sort(key = lambda i: c[i])
  return b

import unittest

class TestSortbyonebits(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(sortbyonebits([0, 1, 2, 3, 4, 5, 6, 7, 8]), [0, 1, 2, 4, 8, 3, 5, 6, 7], 'example 1')

  def test_ex2(self):
    self.assertEqual(sortbyonebits([1024, 512, 256, 128, 64]), [64, 128, 256, 512, 1024], 'example 2')

unittest.main()
