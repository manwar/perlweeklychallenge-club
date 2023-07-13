#! /usr/bin/python3

def leftrightsumdiff(a):
  al = len(a) - 1
  left = [0]
  right = [0]
  for i in range(al):
    left.append(left[i] + a[i])
    right.append(right[i] + a[al - i])
  right.reverse()
  return [abs(l - r) for l, r in zip(left, right)]

import unittest

class TestLeftrightsumdiff(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(leftrightsumdiff([10, 4, 8, 3]), [15, 1, 11, 22], 'example 1')

  def test_ex2(self):
    self.assertEqual(leftrightsumdiff([1]), [0], 'example 2')

  def test_ex3(self):
    self.assertEqual(leftrightsumdiff([1, 2, 3, 4, 5]), [14, 11, 6, 1, 10], 'example 3')

unittest.main()
