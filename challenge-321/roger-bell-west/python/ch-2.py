#! /usr/bin/python3

def backspacecompare(a, b):
  sa = []
  for i in [a, b]:
    oa = []
    for c in i:
      if c == "#":
        oa.pop()
      else:
        oa.append(c)
    sa.append("".join(oa))
  return sa[0] == sa[1]

import unittest

class TestBackspacecompare(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(backspacecompare("ab#c", "ad#c"), True, 'example 1')

  def test_ex2(self):
    self.assertEqual(backspacecompare("ab##", "a#b#"), True, 'example 2')

  def test_ex3(self):
    self.assertEqual(backspacecompare("a#b", "c"), False, 'example 3')

unittest.main()
