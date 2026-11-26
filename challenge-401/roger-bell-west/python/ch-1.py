#! /usr/bin/python3

from fractions import Fraction

def fractionaladditionsubstraction(a):
  terms = []
  state = 0
  n = 0
  num = 0
  sign = 0
  i = 0
  digits = [chr(ascii) for ascii in list(range(ord('0'), ord('9')+1))]
  while i < len(a):
    match state:
      case 0:
        match a[i]:
          case '+':
            state = 0
            i += 1
          case f if a[i] in digits:
            sign = 1
            state = 1
            n = int(f)
            i += 1
          case '-':
            sign = -1
            state = 1
            n = 0
            i += 1
      case 1:
        match a[i]:
          case f if a[i] in digits:
            n = n * 10 + int(f)
            i += 1
          case '/':
            num = n * sign
            n = 0
            state = 2
            i += 1
      case 2:
        match a[i]:
          case f if a[i] in digits:
            n = n * 10 + int(f)
            i += 1
          case _:
            terms.append(Fraction(num, n))
            state = 0
  if state == 2:        
    terms.append(Fraction(num, n))
  out = terms[0]
  for nti in range(1, len(terms)):
    out += terms[nti]
  return str(out.numerator) + "/" + str(out.denominator)

import unittest

class TestFractionaladditionsubstraction(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(fractionaladditionsubstraction("1/2+3/2"), "2/1", 'example 1')

  def test_ex2(self):
    self.assertEqual(fractionaladditionsubstraction("-5/2-3/2"), "-4/1", 'example 2')

  def test_ex3(self):
    self.assertEqual(fractionaladditionsubstraction("5/3-5/3"), "0/1", 'example 3')

  def test_ex4(self):
    self.assertEqual(fractionaladditionsubstraction("10/10-1/10+2/5"), "13/10", 'example 4')

  def test_ex5(self):
    self.assertEqual(fractionaladditionsubstraction("1/6+1/6+1/6"), "1/2", 'example 5')

unittest.main()
