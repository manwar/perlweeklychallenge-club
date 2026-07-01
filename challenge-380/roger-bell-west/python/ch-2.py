#! /usr/bin/python3

def reversedegree(a):
  t = 0
  z0 = ord('z') + 1
  for i, c in enumerate(a):
    t += (z0 - ord(c)) * (1 + i)
  return t

import unittest

class TestReversedegree(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(reversedegree("z"), 1, 'example 1')

  def test_ex2(self):
    self.assertEqual(reversedegree("a"), 26, 'example 2')

  def test_ex3(self):
    self.assertEqual(reversedegree("bbc"), 147, 'example 3')

  def test_ex4(self):
    self.assertEqual(reversedegree("racecar"), 560, 'example 4')

  def test_ex5(self):
    self.assertEqual(reversedegree("zyx"), 14, 'example 5')

unittest.main()
