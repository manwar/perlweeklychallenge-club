#! /usr/bin/python3

def upperlower(a):
  out = ""
  for c in a:
    out += chr(ord(c) ^ 32)
  return out

import unittest

class TestUpperlower(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(upperlower("pERL"), "Perl", 'example 1')

  def test_ex2(self):
    self.assertEqual(upperlower("rakU"), "RAKu", 'example 2')

  def test_ex3(self):
    self.assertEqual(upperlower("PyThOn"), "pYtHoN", 'example 3')

unittest.main()
