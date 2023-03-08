#! /usr/bin/python3

import re

def keyboardword(wl):
  rl = re.compile(r"^([qwertyuiop]+|[asdfghjkl]+|[zxcvbnm]+)$", re.IGNORECASE)
  return [w for w in wl if re.match(rl, w)]

import unittest

class TestKeyboardword(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(keyboardword(["Hello", "Alaska", "Dad", "Peace"]), ["Alaska", "Dad"], 'example 1')

  def test_ex2(self):
    self.assertEqual(keyboardword(["OMG", "Bye"]), [], 'example 2')

unittest.main()
