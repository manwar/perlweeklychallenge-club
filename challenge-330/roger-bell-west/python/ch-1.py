#! /usr/bin/python3

def cleardigits(a):
  out = []
  for c in a:
    if c.isdigit():
      out.pop()
    else:
      out.append(c)
  return "".join(out)

import unittest

class TestCleardigits(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(cleardigits("cab12"), "c", 'example 1')

  def test_ex2(self):
    self.assertEqual(cleardigits("xy99"), "", 'example 2')

  def test_ex3(self):
    self.assertEqual(cleardigits("pa1erl"), "perl", 'example 3')

unittest.main()
