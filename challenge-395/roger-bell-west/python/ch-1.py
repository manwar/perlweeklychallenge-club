#! /usr/bin/python3

import re

def parsecomplex(a):
  rx = re.compile(r"^\(?([-0-9]+)\)?\+\(?([-0-9]+)\)?i$")
  mr = re.match(rx, a)
  if mr != None:
    return [int(mr.group(1)), int(mr.group(2))]
  else:
    return [0, 0]

def complexnumber(aa, bb):
  a, b = parsecomplex(aa)
  c, d = parsecomplex(bb)
  ca =  a * c - b * d
  cb = a * d + b * c
  if cb >= 0:
    return str(ca) + "+" + str(cb) + "i"
  else:
    return str(ca) + "+(" + str(cb) + ")i"

import unittest

class TestComplexnumber(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(complexnumber("1+1i", "1+1i"), "0+2i", 'example 1')

  def test_ex2(self):
    self.assertEqual(complexnumber("1+(-1)i", "1+(-1)i"), "0+(-2)i", 'example 2')

  def test_ex3(self):
    self.assertEqual(complexnumber("0+3i", "0+4i"), "-12+0i", 'example 3')

  def test_ex4(self):
    self.assertEqual(complexnumber("3+4i", "3+(-4)i"), "25+0i", 'example 4')

  def test_ex5(self):
    self.assertEqual(complexnumber("50+-20i", "-10+30i"), "100+1700i", 'example 5')

unittest.main()
