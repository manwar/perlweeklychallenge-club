#! /usr/bin/python3

def maximumcount(a):
  pos = 0
  neg = 0
  for n in a:
    if n > 0:
      pos += 1
    elif n < 0:
      neg += 1
  return max(pos, neg)

import unittest

class TestMaximumcount(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(maximumcount([-3, -2, -1, 1, 2, 3]), 3, 'example 1')

  def test_ex2(self):
    self.assertEqual(maximumcount([-2, -1, 0, 0, 1]), 2, 'example 2')

  def test_ex3(self):
    self.assertEqual(maximumcount([1, 2, 3, 4]), 4, 'example 3')

unittest.main()
