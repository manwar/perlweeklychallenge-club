#! /usr/bin/python3

def formatstring(a, n):
  p = [c for c in a if c != '-']
  r = len(p) % n
  if r == 0:
    r += n
  o = ""
  for i, c in enumerate(p):
    if r == i:
      o += '-'
      r += n
    o += c
  return o

import unittest

class TestFormatstring(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(formatstring("ABC-D-E-F", 3), "ABC-DEF", 'example 1')

  def test_ex2(self):
    self.assertEqual(formatstring("A-BC-D-E", 2), "A-BC-DE", 'example 2')

  def test_ex3(self):
    self.assertEqual(formatstring("-A-B-CD-E", 4), "A-BCDE", 'example 3')

unittest.main()
