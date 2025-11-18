#! /usr/bin/python3

import re

def stringalike(a):
  if len(a) % 2 == 1:
    return false
  vt = 0
  mode = 1
  av = False
  rx = re.compile("[aeiou]")
  for i, c in enumerate(a.lower()):
    if i * 2 == len(a):
      mode = -1
    if re.match(rx, c):
      av = True
      vt += mode
  return av and (vt == 0)

import unittest

class TestStringalike(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(stringalike("textbook"), False, 'example 1')

  def test_ex2(self):
    self.assertEqual(stringalike("book"), True, 'example 2')

  def test_ex3(self):
    self.assertEqual(stringalike("AbCdEfGh"), True, 'example 3')

  def test_ex4(self):
    self.assertEqual(stringalike("rhythmmyth"), False, 'example 4')

  def test_ex5(self):
    self.assertEqual(stringalike("UmpireeAudio"), False, 'example 5')

unittest.main()
