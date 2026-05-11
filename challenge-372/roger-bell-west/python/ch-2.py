#! /usr/bin/python3

def largestsubstring(a):
  cc = list(a)
  for offset in reversed(range(1, len(cc))):
    for x in range(len(cc) - offset):
      if cc[x] == cc[x + offset]:
        return offset - 1
  return -1

import unittest

class TestLargestsubstring(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(largestsubstring("aaaaa"), 3, 'example 1')

  def test_ex2(self):
    self.assertEqual(largestsubstring("abcdeba"), 5, 'example 2')

  def test_ex3(self):
    self.assertEqual(largestsubstring("abbc"), 0, 'example 3')

  def test_ex4(self):
    self.assertEqual(largestsubstring("abcaacbc"), 4, 'example 4')

  def test_ex5(self):
    self.assertEqual(largestsubstring("laptop"), 2, 'example 5')

unittest.main()
