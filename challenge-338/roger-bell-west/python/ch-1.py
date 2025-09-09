#! /usr/bin/python3

def highestrow(a):
  return max(sum(x) for x in a)
  
import unittest

class TestHighestrow(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(highestrow([[4, 4, 4, 4], [10, 0, 0, 0], [2, 2, 2, 9]]), 16, 'example 1')

  def test_ex2(self):
    self.assertEqual(highestrow([[1, 5], [7, 3], [3, 5]]), 10, 'example 2')

  def test_ex3(self):
    self.assertEqual(highestrow([[1, 2, 3], [3, 2, 1]]), 6, 'example 3')

  def test_ex4(self):
    self.assertEqual(highestrow([[2, 8, 7], [7, 1, 3], [1, 9, 5]]), 17, 'example 4')

  def test_ex5(self):
    self.assertEqual(highestrow([[10, 20, 30], [5, 5, 5], [0, 100, 0], [25, 25, 25]]), 100, 'example 5')

unittest.main()
