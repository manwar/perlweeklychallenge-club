#! /usr/bin/python3

def brokenkeyboard(a, b):
  bk = set([x.lower() for x in b])
  ct = 0
  for w in a.split(" "):
    nk = set(w.lower())
    inter = nk.intersection(bk)
    if len(inter) == 0:
      ct += 1
  return ct

import unittest

class TestBrokenkeyboard(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(brokenkeyboard("Hello World", ["d"]), 1, 'example 1')

  def test_ex2(self):
    self.assertEqual(brokenkeyboard("apple banana cherry", ["a", "e"]), 0, 'example 2')

  def test_ex3(self):
    self.assertEqual(brokenkeyboard("Coding is fun", []), 3, 'example 3')

  def test_ex4(self):
    self.assertEqual(brokenkeyboard("The Weekly Challenge", ["a", "b"]), 2, 'example 4')

  def test_ex5(self):
    self.assertEqual(brokenkeyboard("Perl and Python", ["p"]), 1, 'example 5')

unittest.main()
