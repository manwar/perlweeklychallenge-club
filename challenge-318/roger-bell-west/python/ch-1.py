#! /usr/bin/python3

def groupposition(a):
  mx = []
  lc = "z"
  for i, c in enumerate(a):
    if i == 0:
      lc = chr(ord(c) + 1)
    if lc == c:
      mc = len(mx)
      mx[mc - 1][1] += 1
    else:
      mx.append([c, 1])
      lc = c
  out = []
  for ms in mx:
    if ms[1] >= 3:
      out.append(ms[0] * ms[1])
  return out

import unittest

class TestGroupposition(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(groupposition("abccccd"), ["cccc"], 'example 1')

  def test_ex2(self):
    self.assertEqual(groupposition("aaabcddddeefff"), ["aaa", "dddd", "fff"], 'example 2')

  def test_ex3(self):
    self.assertEqual(groupposition("abcdd"), [], 'example 3')

unittest.main()
