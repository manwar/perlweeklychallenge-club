#! /usr/bin/python3

def formatphonenumber(a):
  pure = [x for x in a if x >= "0" and x <= "9"]
  left = len(pure)
  out = []
  i = 0
  if left > 4:
    for c in pure:
      out.append(c)
      i += 1
      left -= 1
      if i % 3 == 0:
        out.append("-")
        if left <= 4:
          break
  if left == 4:
    out.append(pure[i])
    out.append(pure[i + 1])
    out.append("-")
    i += 2
  for p in range(i, len(pure)):
    out.append(pure[p])
  return "".join(out)

import unittest

class TestFormatphonenumber(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(formatphonenumber("1-23-45-6"), "123-456", 'example 1')

  def test_ex2(self):
    self.assertEqual(formatphonenumber("1234"), "12-34", 'example 2')

  def test_ex3(self):
    self.assertEqual(formatphonenumber("12 345-6789"), "123-456-789", 'example 3')

  def test_ex4(self):
    self.assertEqual(formatphonenumber("123 4567"), "123-45-67", 'example 4')

  def test_ex5(self):
    self.assertEqual(formatphonenumber("123 456-78"), "123-456-78", 'example 5')

unittest.main()
