#! /usr/bin/python3

def xmatrix(a):
  order = len(a) - 1
  valid = True
  for y, row in enumerate(a):
    for x, value in enumerate(row):
      if x == y or x == order - y:
        if value == 0:
          valid = False
      else:
        if value != 0:
          valid = False
      if not valid:
        break
    if not valid:
      break
  return valid

import unittest

class TestXmatrix(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(xmatrix([[1, 0, 0, 2], [0, 3, 4, 0], [0, 5, 6, 0], [7, 0, 0, 1]]), True, 'example 1')

  def test_ex2(self):
    self.assertEqual(xmatrix([[1, 2, 3], [4, 5, 6], [7, 8, 9]]), False, 'example 2')

  def test_ex3(self):
    self.assertEqual(xmatrix([[1, 0, 2], [0, 3, 0], [4, 0, 5]]), True, 'example 3')

unittest.main()
