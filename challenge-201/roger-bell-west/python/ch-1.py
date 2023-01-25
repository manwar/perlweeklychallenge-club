#! /usr/bin/python3

import unittest

def missingnumber(l):
  v = set(l)
  for i in range(len(l) + 1):
    if i not in v:
      return i
  return 0

class TestMissingnumber(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(missingnumber([0, 1, 3]), 2, 'example 1')

  def test_ex2(self):
    self.assertEqual(missingnumber([0, 1]), 2, 'example 2')

unittest.main()
