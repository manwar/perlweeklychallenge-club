#! /usr/bin/python3

def alphabetindexdigitsum(a, k):
  st = ""
  for c in a:
    st += str(ord(c) - 96)
  v = int(st)
  for _ in range(k):
    j = 0
    while v > 0:
      j += v % 10
      v //= 10
    v = j
  return v

import unittest

class TestAlphabetindexdigitsum(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(alphabetindexdigitsum("abc", 1), 6, 'example 1')

  def test_ex2(self):
    self.assertEqual(alphabetindexdigitsum("az", 2), 9, 'example 2')

  def test_ex3(self):
    self.assertEqual(alphabetindexdigitsum("cat", 1), 6, 'example 3')

  def test_ex4(self):
    self.assertEqual(alphabetindexdigitsum("dog", 2), 8, 'example 4')

  def test_ex5(self):
    self.assertEqual(alphabetindexdigitsum("perl", 3), 6, 'example 5')

unittest.main()
