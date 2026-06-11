#! /usr/bin/python3

def reverseexistence(a):
  c = a[::-1]
  for di in range(len(c) - 1):
    sample = c[di] + c[di + 1]
    if a.find(sample) != -1:
      return True
  return False

import unittest

class TestReverseexistence(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(reverseexistence("abcba"), True, 'example 1')

  def test_ex2(self):
    self.assertEqual(reverseexistence("racecar"), True, 'example 2')

  def test_ex3(self):
    self.assertEqual(reverseexistence("abcd"), False, 'example 3')

  def test_ex4(self):
    self.assertEqual(reverseexistence("banana"), True, 'example 4')

  def test_ex5(self):
    self.assertEqual(reverseexistence("hello"), True, 'example 5')

unittest.main()
