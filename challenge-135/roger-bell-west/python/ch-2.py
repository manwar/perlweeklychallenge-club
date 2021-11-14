#! /usr/bin/python3

import unittest

def sedolv(sedol):
  if len(sedol) != 7:
    return 0
  w=[1,3,1,7,3,9,1]
  s=0
  for i in range(7):
    n=0
    if sedol[i].isdigit():
      n=int(sedol[i])
    elif sedol[i].isalpha() and sedol[i].isupper() and not sedol[i] in "AEIOU":
      n=ord(sedol[i])-55
    else:
      return 0
    s+=n*w[i]
  if s % 10 == 0:
    return 1
  return 0

class TestSedolv(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(sedolv("2936921"),1,"example ")

        def test_ex2(self):
          self.assertEqual(sedolv("1234567"),0,"example ")

        def test_ex3(self):
          self.assertEqual(sedolv("B0YBKL9"),1,"example ")

        def test_ex4(self):
          self.assertEqual(sedolv("A0ZBKL9"),0,"example ")

        def test_ex5(self):
          self.assertEqual(sedolv("B2YBIL9"),0,"example ")

unittest.main()
