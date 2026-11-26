#! /usr/bin/python3

from collections import Counter

def reconstructdigits(a):
  digits = ["zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]
  cc = []
  for d in range(10):
    cc.append(Counter(list(digits[d])))
  cs = Counter(list(a))
  ol = []
  for d in [2, 6, 0, 7, 4, 3, 5, 8, 1, 9]:
    while cc[d] <= cs:
      ol.append(d)
      cs = cs - cc[d]
  ol.sort()
  return "".join([str(x) for x in ol])

import unittest

class TestReconstructdigits(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(reconstructdigits("zroezerotwowtwotwo"), "00222", 'example 1')

  def test_ex2(self):
    self.assertEqual(reconstructdigits("esveeneinght"), "78", 'example 2')

  def test_ex3(self):
    self.assertEqual(reconstructdigits("oneenineeninefive"), "1599", 'example 3')

  def test_ex4(self):
    self.assertEqual(reconstructdigits("zeroonetwothreeeightfivesixsevenninefour"), "0123456789", 'example 4')

  def test_ex5(self):
    self.assertEqual(reconstructdigits("ninenineninenine"), "9999", 'example 5')

unittest.main()
