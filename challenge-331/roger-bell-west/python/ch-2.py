#! /usr/bin/python3

def buddystrings(a, b):
  bc = list(b)
  for i in range(len(a) - 1):
    for j in range(i + 1, len(a)):
      acx = list(a)
      acx[i] = a[j]
      acx[j] = a[i]
      if acx == bc:
        return True
  return False
import unittest

class TestBuddystrings(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(buddystrings("fuck", "fcuk"), True, 'example 1')

  def test_ex2(self):
    self.assertEqual(buddystrings("love", "love"), False, 'example 2')

  def test_ex3(self):
    self.assertEqual(buddystrings("fodo", "food"), True, 'example 3')

  def test_ex4(self):
    self.assertEqual(buddystrings("feed", "feed"), True, 'example 4')

unittest.main()
