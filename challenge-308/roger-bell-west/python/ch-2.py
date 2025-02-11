#! /usr/bin/python3

def decodexor(a, init):
  out = [init]
  for v in a:
    out.append(out[-1] ^ v)
  return out

import unittest

class TestDecodexor(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(decodexor([1, 2, 3], 1), [1, 0, 2, 1], 'example 1')

  def test_ex2(self):
    self.assertEqual(decodexor([6, 2, 7, 3], 4), [4, 2, 0, 7, 4], 'example 2')

unittest.main()
