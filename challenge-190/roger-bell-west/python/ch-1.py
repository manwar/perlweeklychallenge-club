#! /usr/bin/python3

import unittest
import re

def capitaldetection(s):
  if re.match(r"^([A-Z]+|[a-z]+|[A-Z][a-z]+)$", s):
    return True
  else:
    return False

class TestCapitaldetection(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(capitaldetection("Perl"), True, 'example 1')

  def test_ex2(self):
    self.assertEqual(capitaldetection("TPF"), True, 'example 2')

  def test_ex3(self):
    self.assertEqual(capitaldetection("PyThon"), False, 'example 3')

  def test_ex4(self):
    self.assertEqual(capitaldetection("raku"), True, 'example 4')

unittest.main()
