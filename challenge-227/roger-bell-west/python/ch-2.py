#! /usr/bin/python3

def roman2int(roman):
  if roman == "":
    return 0
  for s in [
    [ 'M', 1000 ],
    [ 'CM', 900 ],
    [ 'D', 500 ],
    [ 'CD', 400 ],
    [ 'C', 100 ],
    [ 'XC', 90 ],
    [ 'L', 50 ],
    [ 'XL', 40 ],
    [ 'X', 10 ],
    [ 'IX', 9 ],
    [ 'V', 5 ],
    [ 'IV', 4 ],
    [ 'I', 1 ],
       ]:
    if roman.startswith(s[0]):
      return s[1] + roman2int(roman[len(s[0]):])
  return 0

def int2roman(n0):
  number = n0
  mn = ""
  for s in [
    [ 'M', 1000 ],
    [ 'CM', 900 ],
    [ 'D', 500 ],
    [ 'CD', 400 ],
    [ 'C', 100 ],
   [ 'XC', 90 ],
    [ 'L', 50 ],
    [ 'XL', 40 ],
    [ 'X', 10 ],
    [ 'IX', 9 ],
    [ 'V', 5 ],
    [ 'IV', 4 ],
    [ 'I', 1 ],
       ]:
    while s[1] <= number:
      mn += s[0]
      number -= s[1]
  return mn

def romanmaths(ax):
  elems = ax.split(' ')
  a = roman2int(elems[0])
  b = roman2int(elems[2])
  c = -1
  if elems[1] == '+':
    c = a + b
  elif elems[1] == '-':
    c = a - b
  elif elems[1] == '*':
    c = a * b;
  elif elems[1] == '/':
    if a % b == 0:
      c = a / b
  elif (elems[1] == '**'):
      c = a ** b
  if c > 3999 or c < 0:
    return 'non potest'
  elif c == 0:
    return 'nulla'
  else:
    return int2roman(c)

import unittest

class TestRoman2int(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(roman2int("I"), 1, 'example 1')

  def test_ex2(self):
    self.assertEqual(roman2int("II"), 2, 'example 2')

  def test_ex3(self):
    self.assertEqual(roman2int("IV"), 4, 'example 3')

  def test_ex4(self):
    self.assertEqual(roman2int("IX"), 9, 'example 4')

  def test_ex5(self):
    self.assertEqual(roman2int("XXX"), 30, 'example 5')

  def test_ex6(self):
    self.assertEqual(roman2int("MDCLXVI"), 1666, 'example 6')

  def test_ex7(self):
    self.assertEqual(int2roman(1), "I", 'example 7')

  def test_ex8(self):
    self.assertEqual(int2roman(2), "II", 'example 8')

  def test_ex9(self):
    self.assertEqual(int2roman(4), "IV", 'example 9')

  def test_ex10(self):
    self.assertEqual(int2roman(9), "IX", 'example 10')

  def test_ex11(self):
    self.assertEqual(int2roman(30), "XXX", 'example 11')

  def test_ex12(self):
    self.assertEqual(int2roman(1666), "MDCLXVI", 'example 12')

  def test_ex13(self):
    self.assertEqual(romanmaths("IV + V"), "IX", 'example 13')

  def test_ex14(self):
    self.assertEqual(romanmaths("M - I"), "CMXCIX", 'example 14')

  def test_ex15(self):
    self.assertEqual(romanmaths("X / II"), "V", 'example 15')

  def test_ex16(self):
    self.assertEqual(romanmaths("XI * VI"), "LXVI", 'example 16')

  def test_ex17(self):
    self.assertEqual(romanmaths("VII ** III"), "CCCXLIII", 'example 17')

  def test_ex18(self):
    self.assertEqual(romanmaths("V - V"), "nulla", 'example 18')

  def test_ex19(self):
    self.assertEqual(romanmaths("V / II"), "non potest", 'example 19')

  def test_ex20(self):
    self.assertEqual(romanmaths("MMM + M"), "non potest", 'example 20')

  def test_ex21(self):
    self.assertEqual(romanmaths("V - X"), "non potest", 'example 21')

unittest.main()
