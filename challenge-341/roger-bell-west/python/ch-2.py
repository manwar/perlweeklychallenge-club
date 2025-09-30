#! /usr/bin/python3

def reverseprefix(a, f):
  c = list(a)
  p = a.find(f)
  if p > -1:
    jr = c[0:p + 1]
    jr = jr[::-1]
    for i, l in enumerate(jr):
      c[i] = l
  return "".join(c)

import unittest

class TestReverseprefix(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(reverseprefix("programming", "g"), "gorpramming", 'example 1')

  def test_ex2(self):
    self.assertEqual(reverseprefix("hello", "h"), "hello", 'example 2')

  def test_ex3(self):
    self.assertEqual(reverseprefix("abcdefghij", "h"), "hgfedcbaij", 'example 3')

  def test_ex4(self):
    self.assertEqual(reverseprefix("reverse", "s"), "srevere", 'example 4')

  def test_ex5(self):
    self.assertEqual(reverseprefix("perl", "r"), "repl", 'example 5')

unittest.main()
