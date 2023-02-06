#! /usr/bin/python3

import unittest

def consecutiveodds(a):
  i = 0
  for v in a:
    if v % 2 == 1:
      i += 1
      if i >= 3:
        return True
    else:
      i = 0
  return False

class TestConsecutiveodds(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(consecutiveodds([1, 5, 3, 6]), True, 'example 1')

  def test_ex2(self):
    self.assertEqual(consecutiveodds([2, 6, 3, 5]), False, 'example 2')

  def test_ex3(self):
    self.assertEqual(consecutiveodds([1, 2, 3, 4]), False, 'example 3')

  def test_ex4(self):
    self.assertEqual(consecutiveodds([2, 3, 5, 7]), True, 'example 4')

unittest.main()
