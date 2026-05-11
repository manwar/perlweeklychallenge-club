#! /usr/bin/python3

def rearrangespaces(a):
  words = []
  spaces = 0
  ww = ""
  for c in a:
    if c == " ":
      spaces += 1
      if ww != "":
        words.append(ww)
        ww = ""
    else:
      ww += c
  if ww != "":
    words.append(ww)
  spdiv = 0
  remainder = spaces
  divs = len(words) - 1
  if divs > 0:
    spdiv = spaces // divs
    remainder = spaces % divs
  out = (" " * spdiv).join(words)
  if remainder > 0:
    out += " " * remainder
  return out

import unittest

class TestRearrangespaces(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(rearrangespaces("  challenge  "), "challenge    ", 'example 1')

  def test_ex2(self):
    self.assertEqual(rearrangespaces("coding  is  fun"), "coding  is  fun", 'example 2')

  def test_ex3(self):
    self.assertEqual(rearrangespaces("a b c  d"), "a b c d ", 'example 3')

  def test_ex4(self):
    self.assertEqual(rearrangespaces("  team      pwc  "), "team          pwc", 'example 4')

  def test_ex5(self):
    self.assertEqual(rearrangespaces("   the  weekly  challenge  "), "the    weekly    challenge ", 'example 5')

unittest.main()
