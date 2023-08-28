#! /usr/bin/python3

def notminmax(a):
  mn = min(a)
  mx = max(a)
  return [x for x in a if x != mn and x != mx]

import unittest

class TestNotminmax(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(notminmax([3, 2, 1, 4]), [3, 2], 'example 1')

  def test_ex2(self):
    self.assertEqual(notminmax([3, 1]), [], 'example 2')

  def test_ex3(self):
    self.assertEqual(notminmax([2, 1, 3]), [2], 'example 3')

unittest.main()
