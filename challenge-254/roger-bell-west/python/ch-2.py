#! /usr/bin/python3

def is_vowel(c):
  match c.lower():
    case 'a' | 'e' | 'i' | 'o' | 'u':
      return True
    case _:
      return False

def reversevowels(a):
  q = [c for c in a if is_vowel(c)]
  qi = len(q)
  o = []
  for c in a:
    if is_vowel(c):
      qi -= 1
      nc = q[qi]
      if c.isupper():
        nc = nc.upper()
      else:
        nc = nc.lower()
      o.append(nc)
    else:
      o.append(c)
  return "".join(o)

import unittest

class TestReversevowels(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(reversevowels("Raku"), "Ruka", 'example 1')

  def test_ex2(self):
    self.assertEqual(reversevowels("Perl"), "Perl", 'example 2')

  def test_ex3(self):
    self.assertEqual(reversevowels("Julia"), "Jaliu", 'example 3')

  def test_ex4(self):
    self.assertEqual(reversevowels("Uiua"), "Auiu", 'example 4')

unittest.main()
