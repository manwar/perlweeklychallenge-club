#! /usr/bin/python3

def decryptstring(a):
  out = ""
  s = 0
  while s < len(a):
    m = int(a[s])
    if s + 2 < len(a) and a[s + 2] == '#':
      m = m * 10 + int(a[s + 1])
      s += 2
    s += 1
    out += chr(96 + m)
  return out

import unittest

class TestDecryptstring(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(decryptstring("10#11#12"), "jkab", 'example 1')

  def test_ex2(self):
    self.assertEqual(decryptstring("1326#"), "acz", 'example 2')

  def test_ex3(self):
    self.assertEqual(decryptstring("25#24#123"), "yxabc", 'example 3')

  def test_ex4(self):
    self.assertEqual(decryptstring("20#5"), "te", 'example 4')

  def test_ex5(self):
    self.assertEqual(decryptstring("1910#26#"), "aijz", 'example 5')

unittest.main()
