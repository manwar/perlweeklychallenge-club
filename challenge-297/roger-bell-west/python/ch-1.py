#! /usr/bin/python3

def contiguousarray(a):
  for l in reversed(range(2, len(a) + 1, 2)):
    for start in range(len(a) - l + 1):
      end = start + l
      if sum(a[start:end]) * 2 == l:
        return l
  return 0

import unittest

class TestContiguousarray(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(contiguousarray([1, 0]), 2, 'example 1')

  def test_ex2(self):
    self.assertEqual(contiguousarray([0, 1, 0]), 2, 'example 2')

  def test_ex3(self):
    self.assertEqual(contiguousarray([0, 0, 0, 0, 0]), 0, 'example 3')

  def test_ex4(self):
    self.assertEqual(contiguousarray([0, 1, 0, 0, 1, 0]), 4, 'example 4')

unittest.main()
