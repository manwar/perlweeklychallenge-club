#! /usr/bin/python3

import unittest

def greatercharacter(a, k):
  aa = [x for x in a if x > k]
  if len(aa) > 0:
    aa.sort()
    return aa[0]
  else:
    return k

class TestGreatercharacter(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(greatercharacter(['e', 'm', 'u', 'g'], 'b'), 'e', 'example 1')

  def test_ex2(self):
    self.assertEqual(greatercharacter(['d', 'c', 'e', 'f'], 'a'), 'c', 'example 2')

  def test_ex3(self):
    self.assertEqual(greatercharacter(['j', 'a', 'r'], 'o'), 'r', 'example 3')

  def test_ex4(self):
    self.assertEqual(greatercharacter(['d', 'c', 'a', 'f'], 'a'), 'c', 'example 4')

  def test_ex5(self):
    self.assertEqual(greatercharacter(['t', 'g', 'a', 'l'], 'v'), 'v', 'example 5')

unittest.main()
