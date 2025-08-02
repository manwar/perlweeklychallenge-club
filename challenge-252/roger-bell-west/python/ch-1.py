#! /usr/bin/python3

def specialnumbers(a):
  t = 0
  for i, v in enumerate(a):
    if len(a) % (i + 1) == 0:
      t += v * v
  return t

import unittest

class TestSpecialnumbers(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(specialnumbers([1, 2, 3, 4]), 21, 'example 1')

  def test_ex2(self):
    self.assertEqual(specialnumbers([2, 7, 1, 19, 18, 3]), 63, 'example 2')

unittest.main()
