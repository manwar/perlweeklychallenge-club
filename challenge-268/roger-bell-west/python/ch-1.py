#! /usr/bin/python3

def magicnumber(a, b):
  return min(b) - min(a)

import unittest

class TestMagicnumber(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(magicnumber([3, 7, 5], [9, 5, 7]), 2, 'example 1')

  def test_ex2(self):
    self.assertEqual(magicnumber([1, 2, 1], [5, 4, 4]), 3, 'example 2')

  def test_ex3(self):
    self.assertEqual(magicnumber([2], [5]), 3, 'example 3')

unittest.main()
