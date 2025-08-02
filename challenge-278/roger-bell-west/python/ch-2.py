#! /usr/bin/python3

def reverseword(a, c):
  s = a.find(c)
  if s == -1:
    return a
  b = list(a[0:s+1])
  b.sort()
  b.extend(list(a[s+1:]))
  return "".join(b)

import unittest

class TestReverseword(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(reverseword("challenge", "e"), "acehllnge", 'example 1')

  def test_ex2(self):
    self.assertEqual(reverseword("programming", "a"), "agoprrmming", 'example 2')

  def test_ex3(self):
    self.assertEqual(reverseword("champion", "b"), "champion", 'example 3')

unittest.main()
