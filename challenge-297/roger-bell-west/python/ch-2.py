#! /usr/bin/python3

def semiorderedpermutation(a):
  en = len(a)
  s = a.index(1)
  e = a.index(en)
  r = s + (en - e - 1)
  if s > e:
    r -= 1
  return r

import unittest

class TestSemiorderedpermutation(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(semiorderedpermutation([2, 1, 4, 3]), 2, 'example 1')

  def test_ex2(self):
    self.assertEqual(semiorderedpermutation([2, 4, 1, 3]), 3, 'example 2')

  def test_ex3(self):
    self.assertEqual(semiorderedpermutation([1, 3, 2, 4, 5]), 0, 'example 3')

unittest.main()
