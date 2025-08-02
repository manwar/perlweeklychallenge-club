#! /usr/bin/python3

import re

def sortstring(a):
  words = a.split(" ")
  out = words.copy()
  pr = re.compile(r'^(.*?)([0-9]+)$')
  for w in words:
    c = pr.search(w)
    index = int(c.group(2)) - 1
    out[index] = c.group(1)
  return " ".join(out)

import unittest

class TestSortstring(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(sortstring("and2 Raku3 cousins5 Perl1 are4"), "Perl and Raku are cousins", 'example 1')

  def test_ex2(self):
    self.assertEqual(sortstring("guest6 Python1 most4 the3 popular5 is2 language7"), "Python is the most popular guest language", 'example 2')

  def test_ex3(self):
    self.assertEqual(sortstring("Challenge3 The1 Weekly2"), "The Weekly Challenge", 'example 3')

unittest.main()
