#! /usr/bin/python3

import unittest

def recomposemac(inp):
  out = ""
  count = 0
  for c in inp:
    if (c >= "0" and c <= "9") or (c >= "a" and c <= "f"):
      if count == 2:
        out += ":"
        count = 0
      count += 1
      out += c
  return out

class TestRecomposemac(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(recomposemac("1ac2.34f0.b1c2"),
                           "1a:c2:34:f0:b1:c2",
                           'example 1')

        def test_ex2(self):
          self.assertEqual(recomposemac("abc1.20f1.345a"),
                           "ab:c1:20:f1:34:5a",
                           'example 2')

unittest.main()
