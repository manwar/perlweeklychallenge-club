#! /usr/bin/python3

def maximumpairs(a):
  n = 0
  r = set()
  for s in a:
    t = s[::-1]
    if t in r:
      n += 1
    else:
      r.add(s)
  return n

import unittest

class TestMaximumpairs(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(maximumpairs(["ab", "de", "ed", "bc"]), 1, 'example 1')

  def test_ex2(self):
    self.assertEqual(maximumpairs(["aa", "ba", "cd", "ed"]), 0, 'example 2')

  def test_ex3(self):
    self.assertEqual(maximumpairs(["uv", "qp", "st", "vu", "mn", "pq"]), 2, 'example 3')

unittest.main()
