#! /usr/bin/python3

import unittest

def lastmember(a0):
  a = a0.copy()
  while len(a) > 1:
    a.sort()
    x = a.pop()
    y = a.pop()
    if x != y:
      a.append(x - y)
  if len(a) == 0:
    return 0
  else:
    return a[0]

class TestLastmember(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(lastmember([2, 7, 4, 1, 8, 1]), 1, 'example 1')

  def test_ex2(self):
    self.assertEqual(lastmember([1]), 1, 'example 2')

  def test_ex3(self):
    self.assertEqual(lastmember([1, 1]), 0, 'example 3')

unittest.main()
