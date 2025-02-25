#! /usr/bin/python3

def consecutivesequence(a):
  b = a.copy()
  b.sort()
  mxlen = 0
  here = 0
  while True:
    for there in range(here + 1, len(b)):
      if b[there] != there - here + b[here]:
        l = there - here
        if l > mxlen:
          mxlen = l
        here = there
        break
      if there == len(b) - 1:
        l = there - here + 1
        if l > mxlen:
          mxlen = l
        here = there
        break
    if here >= len(b) - 1:
      break
  if mxlen < 2:
    mxlen = -1
  return mxlen

import unittest

class TestConsecutivesequence(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(consecutivesequence([10, 4, 20, 1, 3, 2]), 4, 'example 1')

  def test_ex2(self):
    self.assertEqual(consecutivesequence([0, 6, 1, 8, 5, 2, 4, 3, 0, 7]), 9, 'example 2')

  def test_ex3(self):
    self.assertEqual(consecutivesequence([10, 30, 20]), -1, 'example 3')

unittest.main()
