#! /usr/bin/python3

def closestpalindrome(a):
  n = int(a)
  delta = -1
  while True:
    q = str(n + delta)
    if q == q[::-1]:
      return q
    delta = -delta
    if delta < 0:
      delta -= 1

import unittest

class TestClosestpalindrome(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(closestpalindrome("123"), "121", 'example 1')

  def test_ex2(self):
    self.assertEqual(closestpalindrome("2"), "1", 'example 2')

  def test_ex3(self):
    self.assertEqual(closestpalindrome("1400"), "1441", 'example 3')

  def test_ex4(self):
    self.assertEqual(closestpalindrome("1000"), "999", 'example 4')

unittest.main()
