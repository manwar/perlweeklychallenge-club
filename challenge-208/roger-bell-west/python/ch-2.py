#! /usr/bin/python3

import unittest

def duplicateandmissing(a):
  flags = 0
  dup = 0
  mis = 0
  exp = a[0]
  for n in a:
    if n < exp:
      dup = n
      flags |= 1
    elif n > exp:
      mis = exp
      flags |= 2
    if flags == 3:
      return [dup, mis]
    exp = n + 1
  if flags == 1:
    return [dup, exp]
  return [-1]

class TestDuplicateandmissing(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(duplicateandmissing([1, 2, 2, 4]), [2, 3], 'example 1')

  def test_ex2(self):
    self.assertEqual(duplicateandmissing([1, 2, 3, 4]), [-1], 'example 2')

  def test_ex3(self):
    self.assertEqual(duplicateandmissing([1, 2, 3, 3]), [3, 4], 'example 3')

unittest.main()
