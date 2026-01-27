#! /usr/bin/python3

def posmod(x, y):
  z = x % y
  while z < 0:
    z += y
  return z

def rotx(a, offset):
  o = posmod(offset, 26)
  base = 0
  if a >= 'a' and a <= 'z':
    base = ord('a')
  elif a >= 'A' and a <= 'Z':
    base = ord('A')
  else:
    return a
  c = posmod(ord(a) - base + o, 26) + base
  return chr(c)

def encryptedstring(a, offset):
  return "".join(rotx(x, offset) for x in a)
  
import unittest

class TestEncryptedstring(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(encryptedstring("abc", 1), "bcd", 'example 1')

  def test_ex2(self):
    self.assertEqual(encryptedstring("xyz", 2), "zab", 'example 2')

  def test_ex3(self):
    self.assertEqual(encryptedstring("abc", 27), "bcd", 'example 3')

  def test_ex4(self):
    self.assertEqual(encryptedstring("hello", 5), "mjqqt", 'example 4')

  def test_ex5(self):
    self.assertEqual(encryptedstring("perl", 26), "perl", 'example 5')

unittest.main()
