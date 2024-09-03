#! /usr/bin/python3

def noconnection(a):
  os = set(x[0] for x in a)
  iis = set(x[1] for x in a)
  return list(iis.difference(os))[0]

import unittest

class TestNoconnection(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(noconnection([["B", "C"], ["D", "B"], ["C", "A"]]), "A", 'example 1')

  def test_ex2(self):
    self.assertEqual(noconnection([["A", "Z"]]), "Z", 'example 2')

unittest.main()
