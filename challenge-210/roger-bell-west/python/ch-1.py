#! /usr/bin/python3

import unittest

def killandwin(a):
  return sum(a)

class TestKillandwin(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(killandwin([2, 3, 1]), 6, 'example 1')

  def test_ex2(self):
    self.assertEqual(killandwin([1, 1, 2, 2, 2, 3]), 11, 'example 2')

unittest.main()
