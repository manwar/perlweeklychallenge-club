#! /usr/bin/python3

def maxoddbinary(a):
  ones = 0
  zeroes = 0
  for c in a:
    if c == '0':
      zeroes += 1
    elif c == '1':
      ones += 1
  if ones < 1:
    return ""
  out = ""
  out += "1" * (ones - 1)
  out += "0" * zeroes
  out += "1"
  return out

import unittest

class TestMaxoddbinary(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(maxoddbinary("1011"), "1101", 'example 1')

  def test_ex2(self):
    self.assertEqual(maxoddbinary("100"), "001", 'example 2')

  def test_ex3(self):
    self.assertEqual(maxoddbinary("111000"), "110001", 'example 3')

  def test_ex4(self):
    self.assertEqual(maxoddbinary("0101"), "1001", 'example 4')

  def test_ex5(self):
    self.assertEqual(maxoddbinary("1111"), "1111", 'example 5')

unittest.main()
