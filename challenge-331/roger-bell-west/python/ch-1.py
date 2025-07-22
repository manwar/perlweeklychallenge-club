#! /usr/bin/python3

def lastword(a):
  w = [wx for wx in a.split(" ") if len(wx) > 0]
  return len(w[-1])
import unittest

class TestLastword(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(lastword("The Weekly Challenge"), 9, 'example 1')

  def test_ex2(self):
    self.assertEqual(lastword("   Hello   World    "), 5, 'example 2')

  def test_ex3(self):
    self.assertEqual(lastword("Let's begin the fun"), 3, 'example 3')

unittest.main()
