#! /usr/bin/python3

def runningsum(a):
  b = a
  for i in range(1, len(a)):
    b[i] += b[i-1]
  return b

import unittest

class TestRunningsum(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(runningsum([1, 2, 3, 4, 5]), [1, 3, 6, 10, 15], 'example 1')

  def test_ex2(self):
    self.assertEqual(runningsum([1, 1, 1, 1, 1]), [1, 2, 3, 4, 5], 'example 2')

  def test_ex3(self):
    self.assertEqual(runningsum([0, -1, 1, 2]), [0, -1, 0, 2], 'example 3')

unittest.main()
