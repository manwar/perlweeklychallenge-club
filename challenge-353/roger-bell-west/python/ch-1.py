#! /usr/bin/python3

def maxwords(a):
  return max(len(x.split(" ")) for x in a)

import unittest

class TestMaxwords(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(maxwords(["Hello world", "This is a test", "Perl is great"]), 4, 'example 1')

  def test_ex2(self):
    self.assertEqual(maxwords(["Single"]), 1, 'example 2')

  def test_ex3(self):
    self.assertEqual(maxwords(["Short", "This sentence has six words in total", "A B C", "Just four words here"]), 7, 'example 3')

  def test_ex4(self):
    self.assertEqual(maxwords(["One", "Two parts", "Three part phrase", ""]), 3, 'example 4')

  def test_ex5(self):
    self.assertEqual(maxwords(["The quick brown fox jumps over the lazy dog", "A", "She sells seashells by the seashore", "To be or not to be that is the question"]), 10, 'example 5')

unittest.main()
