#! /usr/bin/python3

def echochamber(a):
  out = ""
  for i, c in enumerate(a):
    out += c * (i + 1)
  return out

import unittest

class TestEchochamber(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(echochamber("abca"), "abbcccaaaa", 'example 1')

  def test_ex2(self):
    self.assertEqual(echochamber("xyz"), "xyyzzz", 'example 2')

  def test_ex3(self):
    self.assertEqual(echochamber("code"), "coodddeeee", 'example 3')

  def test_ex4(self):
    self.assertEqual(echochamber("hello"), "heelllllllooooo", 'example 4')

  def test_ex5(self):
    self.assertEqual(echochamber("a"), "a", 'example 5')

unittest.main()
