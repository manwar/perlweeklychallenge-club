#! /usr/bin/python3

def twiceappearance(a):
  m = set()
  for c in a:
    if c in m:
      return c
    m.add(c)
  return 'x'

import unittest

class TestTwiceappearance(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(twiceappearance("acbddbca"), "d", 'example 1')

  def test_ex2(self):
    self.assertEqual(twiceappearance("abccd"), "c", 'example 2')

  def test_ex3(self):
    self.assertEqual(twiceappearance("abcdabbb"), "a", 'example 3')

unittest.main()
