#! /usr/bin/python3

def wordcount(a):
  ct = 0
  for w in a:
    match w[0]:
      case 'a' | 'e' | 'i' | 'o' | 'u':
        ct += 1
      case _:
        match w[-1]:
          case 'a' | 'e' | 'i' | 'o' | 'u':
            ct += 1
  return ct

import unittest

class TestWordcount(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(wordcount(["unicode", "xml", "raku", "perl"]), 2, 'example 1')

  def test_ex2(self):
    self.assertEqual(wordcount(["the", "weekly", "challenge"]), 2, 'example 2')

  def test_ex3(self):
    self.assertEqual(wordcount(["perl", "python", "postgres"]), 0, 'example 3')

unittest.main()
