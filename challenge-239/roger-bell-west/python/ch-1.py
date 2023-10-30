#! /usr/bin/python3

def samestring(a, b):
  return "".join(a) == "".join(b)

import unittest

class TestSamestring(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(samestring(["ab", "c"], ["a", "bc"]), True, 'example 1')

  def test_ex2(self):
    self.assertEqual(samestring(["ab", "c"], ["ac", "b"]), False, 'example 2')

  def test_ex3(self):
    self.assertEqual(samestring(["ab", "cd", "e"], ["abcde"]), True, 'example 3')

unittest.main()
