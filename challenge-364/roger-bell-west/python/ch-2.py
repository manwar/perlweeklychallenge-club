#! /usr/bin/python3

def goalparser(a):
  out = ""
  s = 0
  while s < len(a):
    if a.startswith("G", s):
      s += 1
      out += "G"
    elif a.startswith("()", s):
      s += 2
      out += "o"
    elif a.startswith("(al)", s):
      s += 4
      out += "al"
    else:
      return ""
  return out

import unittest

class TestGoalparser(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(goalparser("G()(al)"), "Goal", 'example 1')

  def test_ex2(self):
    self.assertEqual(goalparser("G()()()()(al)"), "Gooooal", 'example 2')

  def test_ex3(self):
    self.assertEqual(goalparser("(al)G(al)()()"), "alGaloo", 'example 3')

  def test_ex4(self):
    self.assertEqual(goalparser("()G()G"), "oGoG", 'example 4')

  def test_ex5(self):
    self.assertEqual(goalparser("(al)(al)G()()"), "alalGoo", 'example 5')

unittest.main()
