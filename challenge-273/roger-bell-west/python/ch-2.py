#! /usr/bin/python3

def baftera(a):
  firstb = a.find("b")
  if firstb == -1:
    return False
  lasta = a.rfind("a")
  if lasta == -1:
    return True
  return lasta < firstb

import unittest

class TestBaftera(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(baftera("aabb"), True, 'example 1')

  def test_ex2(self):
    self.assertEqual(baftera("abab"), False, 'example 2')

  def test_ex3(self):
    self.assertEqual(baftera("aaa"), False, 'example 3')

  def test_ex4(self):
    self.assertEqual(baftera("bbb"), True, 'example 4')

unittest.main()
