#! /usr/bin/python3

import unittest

def seniorcitizens(a):
  return sum(1 for s in a if s[11] >= "6")

class TestSeniorcitizens(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(seniorcitizens(["7868190130M7522", "5303914400F9211", "9273338290F4010"]), 2, 'example 1')

  def test_ex2(self):
    self.assertEqual(seniorcitizens(["1313579440F2036", "2921522980M5644"]), 0, 'example 2')

unittest.main()
