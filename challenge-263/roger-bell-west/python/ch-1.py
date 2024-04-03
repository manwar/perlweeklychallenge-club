#! /usr/bin/python3

def targetindex(a0, k):
  a = a0
  a.sort()
  return [i for i in range(len(a)) if a[i] == k]

import unittest

class TestTargetindex(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(targetindex([1, 5, 3, 2, 4, 2], 2), [1, 2], 'example 1')

  def test_ex2(self):
    self.assertEqual(targetindex([1, 2, 4, 3, 5], 6), [], 'example 2')

  def test_ex3(self):
    self.assertEqual(targetindex([5, 3, 2, 4, 2, 1], 4), [4], 'example 3')

unittest.main()
