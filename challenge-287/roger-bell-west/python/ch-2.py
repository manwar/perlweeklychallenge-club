#! /usr/bin/python3

import re

def validnumber(a):
  integer = r"[-+]?[0-9]+";
  float = r"[-+]?([0-9]+\.[0-9]*|[0-9]*\.[0-9]+)";
  exponential = "(" + integer + "|" + float + ")[Ee]" + integer;
  number = "^(" + integer + "|" + float + "|" +exponential + ")$";
  rx = re.compile(number)
  if re.match(rx, a):
    return True
  return False

import unittest

class TestValidnumber(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(validnumber("1"), True, 'example 1')

  def test_ex2(self):
    self.assertEqual(validnumber("a"), False, 'example 2')

  def test_ex3(self):
    self.assertEqual(validnumber("."), False, 'example 3')

  def test_ex4(self):
    self.assertEqual(validnumber("1.2e4.2"), False, 'example 4')

  def test_ex5(self):
    self.assertEqual(validnumber("-1."), True, 'example 5')

  def test_ex6(self):
    self.assertEqual(validnumber("+1E-8"), True, 'example 6')

  def test_ex7(self):
    self.assertEqual(validnumber(".44"), True, 'example 7')

unittest.main()
