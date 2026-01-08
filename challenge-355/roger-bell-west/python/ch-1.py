#! /usr/bin/python3

def thousandseparator(a):
  out = ""
  s = str(a)
  offset = 2 - ((len(s) + 2) % 3)
  for i, d in enumerate(s): 
    if i > 0 and (i + offset) % 3 == 0:
      out += ","
    out += d
  return out

import unittest

class TestThousandseparator(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(thousandseparator(123), "123", 'example 1')

  def test_ex2(self):
    self.assertEqual(thousandseparator(1234), "1,234", 'example 2')

  def test_ex3(self):
    self.assertEqual(thousandseparator(1000000), "1,000,000", 'example 3')

  def test_ex4(self):
    self.assertEqual(thousandseparator(1), "1", 'example 4')

  def test_ex5(self):
    self.assertEqual(thousandseparator(12345), "12,345", 'example 5')

unittest.main()
