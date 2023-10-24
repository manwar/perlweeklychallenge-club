#! /usr/bin/python3

def buildarray(a):
  return [a[x] for x in a]

import unittest

class TestBuildarray(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(buildarray([0, 2, 1, 5, 3, 4]), [0, 1, 2, 4, 5, 3], 'example 1')

  def test_ex2(self):
    self.assertEqual(buildarray([5, 0, 1, 2, 3, 4]), [4, 5, 0, 1, 2, 3], 'example 2')

unittest.main()
