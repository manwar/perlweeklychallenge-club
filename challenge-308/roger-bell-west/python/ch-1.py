#! /usr/bin/python3

def countcommon(a, b):
  aa = set(a)
  bb = set(b)
  return len(aa.intersection(bb))

import unittest

class TestCountcommon(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(countcommon(["perl", "weekly", "challenge"], ["raku", "weekly", "challenge"]), 2, 'example 1')

  def test_ex2(self):
    self.assertEqual(countcommon(["perl", "raku", "python"], ["python", "java"]), 1, 'example 2')

  def test_ex3(self):
    self.assertEqual(countcommon(["guest", "contribution"], ["fun", "weekly", "challenge"]), 0, 'example 3')

unittest.main()
