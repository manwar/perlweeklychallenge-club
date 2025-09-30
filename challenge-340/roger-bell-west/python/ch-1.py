#! /usr/bin/python3

def duplicateremovals(a):
  b = []
  for c in a:
    if len(b) == 0 or c != b[-1]:
      b.append(c)
    else:
      b.pop()
  return ''.join(b)

import unittest

class TestDuplicateremovals(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(duplicateremovals("abbaca"), "ca", 'example 1')

  def test_ex2(self):
    self.assertEqual(duplicateremovals("azxxzy"), "ay", 'example 2')

  def test_ex3(self):
    self.assertEqual(duplicateremovals("aaaaaaaa"), "", 'example 3')

  def test_ex4(self):
    self.assertEqual(duplicateremovals("aabccba"), "a", 'example 4')

  def test_ex5(self):
    self.assertEqual(duplicateremovals("abcddcba"), "", 'example 5')

unittest.main()
