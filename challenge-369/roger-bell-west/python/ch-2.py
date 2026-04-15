#! /usr/bin/python3

def groupdivision(a0, sz, pad):
  a = a0
  while len(a) % sz != 0:
    a += pad
  out = []
  i = 0
  while i < len(a):
    out.append(a[i:i+sz])
    i += sz
  return out

import unittest

class TestGroupdivision(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(groupdivision("RakuPerl", 4, "*"), ["Raku", "Perl"], 'example 1')

  def test_ex2(self):
    self.assertEqual(groupdivision("Python", 5, "0"), ["Pytho", "n0000"], 'example 2')

  def test_ex3(self):
    self.assertEqual(groupdivision("12345", 3, "x"), ["123", "45x"], 'example 3')

  def test_ex4(self):
    self.assertEqual(groupdivision("HelloWorld", 3, "_"), ["Hel", "loW", "orl", "d__"], 'example 4')

  def test_ex5(self):
    self.assertEqual(groupdivision("AI", 5, "!"), ["AI!!!"], 'example 5')

unittest.main()
