#! /usr/bin/python3

def l2n(a):
  a0 = ord('a')
  t = 0
  for c in a:
    t *= 10
    t += ord(c) - a0
  return t

def sumofwords(a, b, c):
  return l2n(a) + l2n(b) == l2n(c)

import unittest

class TestSumofwords(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(sumofwords("acb", "cba", "cdb"), True, 'example 1')

  def test_ex2(self):
    self.assertEqual(sumofwords("aab", "aac", "ad"), True, 'example 2')

  def test_ex3(self):
    self.assertEqual(sumofwords("bc", "je", "jg"), False, 'example 3')

  def test_ex4(self):
    self.assertEqual(sumofwords("a", "aaaa", "aa"), True, 'example 4')

  def test_ex5(self):
    self.assertEqual(sumofwords("c", "d", "h"), False, 'example 5')

  def test_ex6(self):
    self.assertEqual(sumofwords("gfi", "hbf", "bdhd"), True, 'example 6')

unittest.main()
