#! /usr/bin/python3

def alphanumericstringvalue(a):
  l = []
  for n in a:
    p = 0
    try:
      p = int(n)
    except:
      p = len(n)
    l.append(p)
  return max(l)

import unittest

class TestAlphanumericstringvalue(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(alphanumericstringvalue(["perl", "2", "000", "python", "raku"]), 6, 'example 1')

  def test_ex2(self):
    self.assertEqual(alphanumericstringvalue(["001", "1", "000", "0001"]), 1, 'example 2')

unittest.main()
