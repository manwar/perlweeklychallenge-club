#! /usr/bin/python3

def replacedigits(a):
  out = ""
  prev = 0
  digits = {chr(asc) for asc in list(range(ord('0'), ord('9')+1))}
  for c in a:
    if c >= '0' and c <= '9':
      out += chr(prev + int(c))
    else:
      prev = ord(c)
      out += c
  return out
    

import unittest

class TestReplacedigits(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(replacedigits("a1c1e1"), "abcdef", 'example 1')

  def test_ex2(self):
    self.assertEqual(replacedigits("a1b2c3d4"), "abbdcfdh", 'example 2')

  def test_ex3(self):
    self.assertEqual(replacedigits("b2b"), "bdb", 'example 3')

  def test_ex4(self):
    self.assertEqual(replacedigits("a16z"), "abgz", 'example 4')

unittest.main()
