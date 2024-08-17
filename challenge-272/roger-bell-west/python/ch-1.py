#! /usr/bin/python3

def defrangip(a):
  return a.replace(".", "[.]")

import unittest

class TestDefrangip(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(defrangip("1.1.1.1"), "1[.]1[.]1[.]1", 'example 1')

  def test_ex2(self):
    self.assertEqual(defrangip("255.101.1.0"), "255[.]101[.]1[.]0", 'example 2')

unittest.main()
