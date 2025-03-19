#! /usr/bin/python3

def reverseletters(a):
  vout = [" "] * len(a)
  letterslots = []
  letters = []
  for i, c in enumerate(a):
    if c.isalpha():
      letterslots.append(i)
      letters.append(c)
    else:
      vout[i] = c
  for i in letterslots:
    vout[i] = letters.pop()
  return "".join(vout)

import unittest

class TestReverseletters(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(reverseletters("p-er?l"), "l-re?p", 'example 1')

  def test_ex2(self):
    self.assertEqual(reverseletters("wee-k!L-y"), "yLk-e!e-w", 'example 2')

  def test_ex3(self):
    self.assertEqual(reverseletters("_c-!h_all-en!g_e"), "_e-!g_nel-la!h_c", 'example 3')

unittest.main()
