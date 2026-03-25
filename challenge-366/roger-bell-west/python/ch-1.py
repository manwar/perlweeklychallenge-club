#! /usr/bin/python3

def countprefixes(a, b):
  return len([x for x in a if b.startswith(x)])

import unittest

class TestCountprefixes(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(countprefixes(["a", "ap", "app", "apple", "banana"], "apple"), 4, 'example 1')

  def test_ex2(self):
    self.assertEqual(countprefixes(["cat", "dog", "fish"], "bird"), 0, 'example 2')

  def test_ex3(self):
    self.assertEqual(countprefixes(["hello", "he", "hell", "heaven", "he"], "hello"), 4, 'example 3')

  def test_ex4(self):
    self.assertEqual(countprefixes(["", "code", "coding", "cod"], "coding"), 3, 'example 4')

  def test_ex5(self):
    self.assertEqual(countprefixes(["p", "pr", "pro", "prog", "progr", "progra", "program"], "program"), 7, 'example 5')

unittest.main()
