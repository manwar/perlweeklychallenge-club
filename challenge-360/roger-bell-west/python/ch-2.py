#! /usr/bin/python3

def wordsorter(a):
  w = a.split()
  w.sort(key = str.casefold)
  return " ".join(w)

import unittest

class TestWordsorter(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(wordsorter("The quick brown fox"), "brown fox quick The", 'example 1')

  def test_ex2(self):
    self.assertEqual(wordsorter("Hello    World!   How   are you?"), "are Hello How World! you?", 'example 2')

  def test_ex3(self):
    self.assertEqual(wordsorter("Hello"), "Hello", 'example 3')

  def test_ex4(self):
    self.assertEqual(wordsorter("Hello, World! How are you?"), "are Hello, How World! you?", 'example 4')

  def test_ex5(self):
    self.assertEqual(wordsorter("I have 2 apples and 3 bananas!"), "2 3 and apples bananas! have I", 'example 5')

unittest.main()
