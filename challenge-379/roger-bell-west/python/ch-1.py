#! /usr/bin/python3

def reversestring(a):
  b = ""
  l = len(a) - 1
  for i in range(l + 1):
    b += a[l - i]
  return b

import unittest

class TestReversestring(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(reversestring(""), "", 'example 1')

  def test_ex2(self):
    self.assertEqual(reversestring("reverse the given string"), "gnirts nevig eht esrever", 'example 2')

unittest.main()
