#! /usr/bin/python3

def compressedunit(count, letter):
  out = ""
  if count > 1:
    out += str(count)
  out += letter
  return out

def stringcompression(a):
  out = ""
  lastchar = '@'
  count = 0
  for c in a:
    if count == 0 or c != lastchar:
      if count > 0:
        out += compressedunit(count, lastchar)
      lastchar = c
      count = 0
    count += 1
  if count > 0:
    out += compressedunit(count, lastchar)
  lastchar = c
  return out  

def stringdecompression(a):
  out = ""
  count = 0
  for c in a:
    if c >= '0' and c <= '9':
      count *= 10
      count += int(c)
    else:
      if count == 0:
        count = 1
      out += c * count
      count = 0
  return out

import unittest

class TestStringcompression(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(stringcompression("abbc"), "a2bc", 'example 1')

  def test_ex2(self):
    self.assertEqual(stringcompression("aaabccc"), "3ab3c", 'example 2')

  def test_ex3(self):
    self.assertEqual(stringcompression("abcc"), "ab2c", 'example 3')

  def test_ex4(self):
    self.assertEqual(stringdecompression("a2bc"), "abbc", 'example 4')

  def test_ex5(self):
    self.assertEqual(stringdecompression("3ab3c"), "aaabccc", 'example 5')

  def test_ex6(self):
    self.assertEqual(stringdecompression("ab2c"), "abcc", 'example 6')

unittest.main()
