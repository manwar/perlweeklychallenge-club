#! /usr/bin/python3

def secondlargestdigit(a):
  p = set(c for c in a if c >= '0' and c <= '9')
  k = list(p)
  k.sort()
  k.reverse()
  if len(k) > 1:
    return int(k[1])
  else:
    return -1

import unittest

class TestSecondlargestdigit(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(secondlargestdigit("aaaaa77777"), -1, 'example 1')

  def test_ex2(self):
    self.assertEqual(secondlargestdigit("abcde"), -1, 'example 2')

  def test_ex3(self):
    self.assertEqual(secondlargestdigit("9zero8eight7seven9"), 8, 'example 3')

  def test_ex4(self):
    self.assertEqual(secondlargestdigit("xyz9876543210"), 8, 'example 4')

  def test_ex5(self):
    self.assertEqual(secondlargestdigit("4abc4def2ghi8jkl2"), 4, 'example 5')

unittest.main()
