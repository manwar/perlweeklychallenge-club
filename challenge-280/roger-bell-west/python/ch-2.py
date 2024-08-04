#! /usr/bin/python3

def countasterisks(a):
  out = 0
  active = True
  for c in a:
    match c:
      case '|':
        active = not active
      case '*':
        if active:
          out += 1
  return out

import unittest

class TestCountasterisks(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(countasterisks("p|*e*rl|w**e|*ekly|"), 2, 'example 1')

  def test_ex2(self):
    self.assertEqual(countasterisks("perl"), 0, 'example 2')

  def test_ex3(self):
    self.assertEqual(countasterisks("th|ewe|e**|k|l***ych|alleng|e"), 5, 'example 3')

unittest.main()
