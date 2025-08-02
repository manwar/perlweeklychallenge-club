#! /usr/bin/python3

def groupdigitsum(a, sz):
  s = a
  n = 0
  while True:
    t = ""
    for i, c in enumerate(s):
      n += int(c)
      if i == len(s) - 1 or (i + 1) % sz == 0:
        t += str(n)
        n = 0
    s = t
    if len(s) <= sz:
      break
  return s

import unittest

class TestGroupdigitsum(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(groupdigitsum("111122333", 3), "359", 'example 1')

  def test_ex2(self):
    self.assertEqual(groupdigitsum("1222312", 2), "76", 'example 2')

  def test_ex3(self):
    self.assertEqual(groupdigitsum("100012121001", 4), "162", 'example 3')

unittest.main()
