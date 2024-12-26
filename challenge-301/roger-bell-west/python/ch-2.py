#! /usr/bin/python3

def hammingdistance(a):
  t = 0
  for i in range(len(a) - 1):
    for j in range(i + 1 , len(a)):
      t += (a[i] ^ a[j]).bit_count()
  return t

import unittest

class TestHammingdistance(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(hammingdistance([4, 14, 2]), 6, 'example 1')

  def test_ex2(self):
    self.assertEqual(hammingdistance([4, 14, 4]), 4, 'example 2')

unittest.main()
