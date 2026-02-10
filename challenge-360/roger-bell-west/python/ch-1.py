#! /usr/bin/python3

def textjustifier(intxt, width):
  working = ["*"] * width
  offset = int((width - len(intxt)) / 2)
  for i, c in enumerate(intxt):
    working[i + offset] = c
  return "".join(working)

import unittest

class TestTextjustifier(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(textjustifier("Hi", 5), "*Hi**", 'example 1')

  def test_ex2(self):
    self.assertEqual(textjustifier("Code", 10), "***Code***", 'example 2')

  def test_ex3(self):
    self.assertEqual(textjustifier("Hello", 9), "**Hello**", 'example 3')

  def test_ex4(self):
    self.assertEqual(textjustifier("Perl", 4), "Perl", 'example 4')

  def test_ex5(self):
    self.assertEqual(textjustifier("A", 7), "***A***", 'example 5')

  def test_ex6(self):
    self.assertEqual(textjustifier("", 5), "*****", 'example 6')

unittest.main()
