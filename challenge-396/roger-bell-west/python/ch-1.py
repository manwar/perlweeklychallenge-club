#! /usr/bin/python3

def finishingorder(order, friends):
  return [x for x in order if x in friends]

import unittest

class TestFinishingorder(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(finishingorder([3, 1, 4, 2, 5], [1, 4, 2]), [1, 4, 2], 'example 1')

  def test_ex2(self):
    self.assertEqual(finishingorder([5, 4, 3, 2, 1], [1, 3, 5]), [5, 3, 1], 'example 2')

  def test_ex3(self):
    self.assertEqual(finishingorder([2, 4, 1, 3], [1, 2, 3, 4]), [2, 4, 1, 3], 'example 3')

  def test_ex4(self):
    self.assertEqual(finishingorder([4, 1, 3, 2], [3]), [3], 'example 4')

  def test_ex5(self):
    self.assertEqual(finishingorder([1, 3, 2, 6, 5, 4], [1, 2, 3]), [1, 3, 2], 'example 5')

unittest.main()
