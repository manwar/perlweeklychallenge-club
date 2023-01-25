#! /usr/bin/python3

import unittest

def pennypiles(n):
  if n == 0:
    return 1
  s = 0
  j = n - 1
  k = 2
  while j >= 0:
    t = pennypiles(j)
    if int(k / 2) % 2 == 1:
      s += t
    else:
      s -= t
    if k % 2 == 1:
      j -= k
    else:
      j -= int(k / 2)
    k += 1
  return s

class TestPennypiles(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(pennypiles(5), 7, 'example 1')

  def test_ex2(self):
    self.assertEqual(pennypiles(10), 42, 'example 2')

unittest.main()
