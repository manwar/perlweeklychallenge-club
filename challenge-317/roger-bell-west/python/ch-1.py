#! /usr/bin/python3

def acronyms(a, b):
  os = ""
  for c in a:
    os += c[0]
  return os == b

import unittest

class TestAcronyms(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(acronyms(["Perl", "Weekly", "Challenge"], "PWC"), True, 'example 1')

  def test_ex2(self):
    self.assertEqual(acronyms(["Bob", "Charlie", "Joe"], "BCJ"), True, 'example 2')

  def test_ex3(self):
    self.assertEqual(acronyms(["Morning", "Good"], "MM"), False, 'example 3')

unittest.main()
