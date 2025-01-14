#! /usr/bin/python3

def arrangebinary(a, n):
  b = a
  t = n
  for i in range(len(b)):
    if  b[i] == 0 and (i == 0 or b[i - 1] == 0) and (i == len(b) - 1 or b[i + 1] == 0):
      b[i] = 1
      t -= 1
      if t == 0:
        break
  return t == 0

import unittest

class TestArrangebinary(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(arrangebinary([1, 0, 0, 0, 1], 1), True, 'example 1')

  def test_ex2(self):
    self.assertEqual(arrangebinary([1, 0, 0, 0, 1], 2), False, 'example 2')

unittest.main()
