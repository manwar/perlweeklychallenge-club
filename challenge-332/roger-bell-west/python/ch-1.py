#! /usr/bin/python3

def binarydate(a):
  return "-".join(["{0:b}".format(int(n)) for n in a.split("-")])

import unittest

class TestBinarydate(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(binarydate("2025-07-26"), "11111101001-111-11010", 'example 1')

  def test_ex2(self):
    self.assertEqual(binarydate("2000-02-02"), "11111010000-10-10", 'example 2')

  def test_ex3(self):
    self.assertEqual(binarydate("2024-12-31"), "11111101000-1100-11111", 'example 3')

unittest.main()
