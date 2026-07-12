#! /usr/bin/python3

def smallergreaterelement(a):
  mn = min(a)
  mx = max(a)
  return len([x for x in a if x != mn and x != mx])

import unittest

class TestSmallergreaterelement(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(smallergreaterelement([2, 4]), 0, 'example 1')

  def test_ex2(self):
    self.assertEqual(smallergreaterelement([1, 1, 1, 1]), 0, 'example 2')

  def test_ex3(self):
    self.assertEqual(smallergreaterelement([1, 1, 4, 8, 12, 12]), 2, 'example 3')

  def test_ex4(self):
    self.assertEqual(smallergreaterelement([3, 6, 6, 9]), 2, 'example 4')

  def test_ex5(self):
    self.assertEqual(smallergreaterelement([0, -5, 10, -2, 4]), 3, 'example 5')

unittest.main()
