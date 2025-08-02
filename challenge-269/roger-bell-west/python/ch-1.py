#! /usr/bin/python3

def bitwiseor(a):
  return len([n for n in a if n % 2 == 0]) >= 2

import unittest

class TestBitwiseor(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(bitwiseor([1, 2, 3, 4, 5]), True, 'example 1')

  def test_ex2(self):
    self.assertEqual(bitwiseor([2, 3, 8, 16]), True, 'example 2')

  def test_ex3(self):
    self.assertEqual(bitwiseor([1, 2, 5, 7, 9]), False, 'example 3')

unittest.main()
