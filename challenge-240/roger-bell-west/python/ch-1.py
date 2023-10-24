#! /usr/bin/python3

def acronym(strs, chk):
  return "".join(x[0] for x in strs).lower() == chk.lower()

import unittest

class TestAcronym(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(acronym(["Perl", "Python", "Pascal"], "ppp"), True, 'example 1')

  def test_ex2(self):
    self.assertEqual(acronym(["Perl", "Raku"], "rp"), False, 'example 2')

  def test_ex3(self):
    self.assertEqual(acronym(["Oracle", "Awk", "C"], "oac"), True, 'example 3')

unittest.main()
