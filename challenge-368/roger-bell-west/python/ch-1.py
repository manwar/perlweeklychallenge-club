#! /usr/bin/python3

def makeitbigger(st, ch):
  nn = []
  for i in range(len(st)):
    if st[i] == ch:
      nv = st[0:i] + st[i+1:]
      nn.append(int(nv))
  return str(max(nn))

import unittest

class TestMakeitbigger(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(makeitbigger("15456", "5"), "1546", 'example 1')

  def test_ex2(self):
    self.assertEqual(makeitbigger("7332", "3"), "732", 'example 2')

  def test_ex3(self):
    self.assertEqual(makeitbigger("2231", "2"), "231", 'example 3')

  def test_ex4(self):
    self.assertEqual(makeitbigger("543251", "5"), "54321", 'example 4')

  def test_ex5(self):
    self.assertEqual(makeitbigger("1921", "1"), "921", 'example 5')

unittest.main()
