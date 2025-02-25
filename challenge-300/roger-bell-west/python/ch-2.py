#! /usr/bin/python3

def nestedarray(a):
  arr = 0
  for i in range(len(a)):
    trail = set()
    j = i
    while True:
      j = a[j]
      if j in trail:
        break
      trail.add(j)
    arr = max([arr, len(trail)])
  return arr

import unittest

class TestNestedarray(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(nestedarray([5, 4, 0, 3, 1, 6, 2]), 4, 'example 1')

  def test_ex2(self):
    self.assertEqual(nestedarray([0, 1, 2]), 1, 'example 2')

unittest.main()
