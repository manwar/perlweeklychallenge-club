#! /usr/bin/python3

def sortletters(a, n):
  out = a.copy()
  for i, l in enumerate(a):
    out[n[i] - 1] = l
  return "".join(out)

import unittest

class TestSortletters(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(sortletters(["R", "E", "P", "L"], [3, 2, 1, 4]), "PERL", 'example 1')

  def test_ex2(self):
    self.assertEqual(sortletters(["A", "U", "R", "K"], [2, 4, 1, 3]), "RAKU", 'example 2')

  def test_ex3(self):
    self.assertEqual(sortletters(["O", "H", "Y", "N", "P", "T"], [5, 4, 2, 6, 1, 3]), "PYTHON", 'example 3')

unittest.main()
