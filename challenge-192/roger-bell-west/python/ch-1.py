#! /usr/bin/python3

import unittest

def binaryflip(n):
  m = n
  r = 0
  while m > 0:
    m >>= 1
    r += 1
  return (1 << r) - 1 - n

class TestBinaryflip(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(binaryflip(5), 2, 'example 1')

  def test_ex2(self):
    self.assertEqual(binaryflip(4), 3, 'example 2')

  def test_ex3(self):
    self.assertEqual(binaryflip(6), 1, 'example 3')

unittest.main()
