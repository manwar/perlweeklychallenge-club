#! /usr/bin/python3

def prefixwords(s, p):
  return len([True for st in s if st.startswith(p)])

import unittest

class TestPrefixwords(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(prefixwords(["pay", "attention", "practice", "attend"], "at"), 2, 'example 1')

  def test_ex2(self):
    self.assertEqual(prefixwords(["janet", "julia", "java", "javascript"], "ja"), 3, 'example 2')

unittest.main()
