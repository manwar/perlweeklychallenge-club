#! /usr/bin/python3

def powerstring(a):
  mx = 0
  prev = 'A'
  cur = 0
  for c in a:
    if cur > 0 and c == prev:
      cur += 1
    else:
      cur = 1
      prev = c
    mx = max(mx, cur)
  return mx

import unittest

class TestPowerstring(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(powerstring("textbook"), 2, 'example 1')

  def test_ex2(self):
    self.assertEqual(powerstring("aaaaa"), 5, 'example 2')

  def test_ex3(self):
    self.assertEqual(powerstring("hoorayyy"), 3, 'example 3')

  def test_ex4(self):
    self.assertEqual(powerstring("x"), 1, 'example 4')

  def test_ex5(self):
    self.assertEqual(powerstring("aabcccddeeffffghijjk"), 4, 'example 5')

unittest.main()
