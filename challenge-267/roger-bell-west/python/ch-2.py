#! /usr/bin/python3

def linecounts(a, w):
  linecount = 1
  linewidth = 0
  asize = ord('a')
  for c in a:
    wd = w[ord(c) - asize]
    if linewidth + wd > 100:
      linecount += 1
      linewidth = wd
    else:
      linewidth += wd
  return [linecount, linewidth]

import unittest

class TestLinecounts(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(linecounts("abcdefghijklmnopqrstuvwxyz", [10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10]), [3, 60], 'example 1')

  def test_ex2(self):
    self.assertEqual(linecounts("bbbcccdddaaa", [4, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10]), [2, 4], 'example 2')

unittest.main()
