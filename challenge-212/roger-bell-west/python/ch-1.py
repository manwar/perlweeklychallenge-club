#! /usr/bin/python3

import unittest

def jumpingletters(word, jump):
  s = ""
  for i, c0 in enumerate(word):
    c = ord(c0)
    d = c + jump[i] % 26
    if (c <= 90 and d > 90) or d > 122:
      d -= 26
    s += chr(d)
  return s

class TestJumpingletters(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(jumpingletters("Perl", [2, 22, 19, 9]), "Raku", 'example 1')

  def test_ex2(self):
    self.assertEqual(jumpingletters("Raku", [24, 4, 7, 17]), "Perl", 'example 2')

unittest.main()
