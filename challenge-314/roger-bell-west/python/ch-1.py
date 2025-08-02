#! /usr/bin/python3

def equalstrings(a):
  mmlen = min(len(x) for x in a)
  si = 0
  for i in range(mmlen):
    si = i
    for s in range(1, len(a)):
      if a[0][i] !=  a[s][i]:
        if i == 0:
          return -1
        si -= 1
        break
  return sum(len(x) for x in a) - len(a) * (si + 1)

import unittest

class TestEqualstrings(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(equalstrings(["abc", "abb", "ab"]), 2, 'example 1')

  def test_ex2(self):
    self.assertEqual(equalstrings(["ayz", "cyz", "xyz"]), -1, 'example 2')

  def test_ex3(self):
    self.assertEqual(equalstrings(["yza", "yzb", "yzc"]), 3, 'example 3')

unittest.main()
