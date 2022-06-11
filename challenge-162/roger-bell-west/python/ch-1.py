#! /usr/bin/python3

import unittest

import re

def generate(in0):
  rnd = re.compile(r"[^0-9]+")
  in1 = rnd.sub("",in0)
  if len(in1) < 12:
    return 99
  s = 0
  m = 1
  for i in in1[0:12]:
    s += int(i) * m
    m = 4 - m
  return (10-(s % 10)) % 10

def validate(in0):
  rnd = re.compile(r"[^0-9]+")
  in1 = rnd.sub("",in0)
  if len(in1) != 13:
    return False
  return generate(in1) == int(in1[-1])

class TestIsbn(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(generate("978-0-306-40615-"),
                           7,
                           'example 1')

        def test_ex2(self):
          self.assertEqual(generate("978-0-306-40615-7"),
                           7,
                           'example 2')

        def test_ex3(self):
          self.assertEqual(validate("978-0-306-40615-7"),
                           True,
                           'example 3')

        def test_ex4(self):
          self.assertEqual(validate("978-0-306-46015-7"),
                           False,
                           'example 4')

unittest.main()
