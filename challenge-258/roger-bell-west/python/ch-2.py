#! /usr/bin/python3

def sumofvalues(a, k):
  return sum(a[i] for i in range(len(a)) if i.bit_count() == k)

import unittest

class TestSumofvalues(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(sumofvalues([2, 5, 9, 11, 3], 1), 17, 'example 1')

  def test_ex2(self):
    self.assertEqual(sumofvalues([2, 5, 9, 11, 3], 2), 11, 'example 2')

  def test_ex3(self):
    self.assertEqual(sumofvalues([2, 5, 9, 11, 3], 0), 2, 'example 3')

unittest.main()
