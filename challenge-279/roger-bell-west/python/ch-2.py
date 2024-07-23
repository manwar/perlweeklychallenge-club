#! /usr/bin/python3

def splitstring(a):
  n = 0
  for cc in a:
    match cc.lower():
      case 'a' | 'e' | 'i' | 'o' | 'u':
        n += 1
  return n % 2 == 0

import unittest

class TestSplitstring(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(splitstring("perl"), False, 'example 1')

  def test_ex2(self):
    self.assertEqual(splitstring("book"), True, 'example 2')

  def test_ex3(self):
    self.assertEqual(splitstring("goodmorning"), True, 'example 3')

unittest.main()
