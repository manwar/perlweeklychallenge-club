#! /usr/bin/python3

def changingkeys(a):
  oc = "x"
  out = 0
  for i, c in enumerate(a.lower()):
    if i == 0:
      oc = c
    elif c != oc:
      oc = c
      out += 1
  return out

import unittest

class TestChangingkeys(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(changingkeys("pPeERrLl"), 3, 'example 1')

  def test_ex2(self):
    self.assertEqual(changingkeys("rRr"), 0, 'example 2')

  def test_ex3(self):
    self.assertEqual(changingkeys("GoO"), 1, 'example 3')

unittest.main()
