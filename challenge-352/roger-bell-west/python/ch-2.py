#! /usr/bin/python3

def binaryprefix(a):
  c = 0
  out = []
  for n in a:
    c *= 2
    c += n
    out.append(c % 5 == 0)
  return out

import unittest

class TestBinaryprefix(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(binaryprefix([0, 1, 1, 0, 0, 1, 0, 1, 1, 1]), [True, False, False, False, False, True, True, False, False, False], 'example 1')

  def test_ex2(self):
    self.assertEqual(binaryprefix([1, 0, 1, 0, 1, 0]), [False, False, True, True, False, False], 'example 2')

  def test_ex3(self):
    self.assertEqual(binaryprefix([0, 0, 1, 0, 1]), [True, True, False, False, True], 'example 3')

  def test_ex4(self):
    self.assertEqual(binaryprefix([1, 1, 1, 1, 1]), [False, False, False, True, False], 'example 4')

  def test_ex5(self):
    self.assertEqual(binaryprefix([1, 0, 1, 1, 0, 1, 0, 0, 1, 1]), [False, False, True, False, False, True, True, True, False, False], 'example 5')

unittest.main()
