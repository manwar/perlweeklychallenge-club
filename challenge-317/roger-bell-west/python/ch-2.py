#! /usr/bin/python3

def friendlystrings(a, b):
  for i in range(len(a) - 1):
    for j in range(i + 1, len(a)):
      cc = list(a)
      (cc[i], cc[j]) = (cc[j], cc[i])
      if "".join(cc) == b:
        return True
  return False

import unittest

class TestFriendlystrings(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(friendlystrings("desc", "dsec"), True, 'example 1')

  def test_ex2(self):
    self.assertEqual(friendlystrings("fuck", "fcuk"), True, 'example 2')

  def test_ex3(self):
    self.assertEqual(friendlystrings("poo", "eop"), False, 'example 3')

  def test_ex4(self):
    self.assertEqual(friendlystrings("stripe", "sprite"), True, 'example 4')

unittest.main()
