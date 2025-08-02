#! /usr/bin/python3

def transfer(a, b):
  ac = ord(a)
  bc = ord(b)
  return min((ac - bc + 26) % 26, (bc - ac + 26) % 26)

def minimumtime(a):
  tot = len(a)
  prev = "a"
  for c in a:
    tot += transfer(prev, c)
    prev = c
  return tot

import unittest

class TestMinimumtime(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(minimumtime("abc"), 5, 'example 1')

  def test_ex2(self):
    self.assertEqual(minimumtime("bza"), 7, 'example 2')

  def test_ex3(self):
    self.assertEqual(minimumtime("zjpc"), 34, 'example 3')

unittest.main()
