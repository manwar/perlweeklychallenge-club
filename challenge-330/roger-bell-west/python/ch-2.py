#! /usr/bin/python3

def titlecapital(a):
  out = []
  for w in a.split(" "):
    p = w.lower()
    if len(p) > 2:
      p = p.title()
    out.append(p)
  return " ".join(out)

import unittest

class TestTitlecapital(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(titlecapital("PERL IS gREAT"), "Perl is Great", 'example 1')

  def test_ex2(self):
    self.assertEqual(titlecapital("THE weekly challenge"), "The Weekly Challenge", 'example 2')

  def test_ex3(self):
    self.assertEqual(titlecapital("YoU ARE A stAR"), "You Are a Star", 'example 3')

unittest.main()
