#! /usr/bin/python3

def arreq(a, b):
  if len(a) != len(b):
    return False
  for i, x in enumerate(a):
    if x != b[i]:
      return False
  return True

def reverseequals(a, b):
  if arreq(a, b):
    return True
  for i in range(len(a) - 1):
    for j in range(i + 1, len(a)):
      c = a.copy()
      for x in range(i, j + 1):
        c[x] = a[j - (x - i)]
      if arreq(c, b):
        return True
  return False

import unittest

class TestReverseequals(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(reverseequals([3, 2, 1, 4], [1, 2, 3, 4]), True, 'example 1')

  def test_ex2(self):
    self.assertEqual(reverseequals([1, 3, 4], [4, 1, 3]), False, 'example 2')

  def test_ex3(self):
    self.assertEqual(reverseequals([2], [2]), True, 'example 3')

unittest.main()
