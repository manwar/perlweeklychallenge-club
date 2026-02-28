#! /usr/bin/python3

def spellboundsorting(a):
  w = a
  w.sort(key = towords)
  return w

def towords(a):
  if a == 0:
    return "zero"
  components = []
  b = a
  if a < 0:
    b = -a
    components.append("minus")
  vw = [
    [1000000000, "milliard"],
    [1000000, "million"],
    [1000, "thousand"],
    [100, "hundred"],
    [90, "ninety"],
    [80, "eighty"],
    [70, "seventy"],
    [60, "sixty"],
    [50, "fifty"],
    [40, "forty"],
    [30, "thirty"],
    [20, "twenty"],
    [19, "nineteen"],
    [18, "eighteen"],
    [17, "seventeen"],
    [16, "sixteen"],
    [15, "fifteen"],
    [14, "fourteen"],
    [13, "thirteen"],
    [12, "twelve"],
    [11, "eleven"],
    [10, "ten"],
    [9, "nine"],
    [8, "eight"],
    [7, "seven"],
    [6, "six"],
    [5, "five"],
    [4, "four"],
    [3, "three"],
    [2, "two"],
    [1, "one"],
  ]
  for w in cw(b, vw):
    components.append(w)
  return " ".join(components)

def cw(n, vw):
  res = []
  for val, word in vw:
    if n >= val:
      andflag = False
      if n >= 100:
        andflag = True
        for w in cw(n // val, vw):
          res.append(w)
      res.append(word)
      p = n % val
      if p > 0:
        if andflag:
          res.append("and")
        for w in cw(p, vw):
          res.append(w)
      break
  return res

import unittest

class TestSpellboundsorting(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(spellboundsorting([6, 7, 8, 9, 10]), [8, 9, 7, 6, 10], 'example 1')

  def test_ex2(self):
    self.assertEqual(spellboundsorting([-3, 0, 1000, 99]), [-3, 99, 1000, 0], 'example 2')

  def test_ex3(self):
    self.assertEqual(spellboundsorting([1, 2, 3, 4, 5]), [5, 4, 1, 3, 2], 'example 3')

  def test_ex4(self):
    self.assertEqual(spellboundsorting([0, -1, -2, -3, -4]), [-4, -1, -3, -2, 0], 'example 4')

  def test_ex5(self):
    self.assertEqual(spellboundsorting([100, 101, 102]), [100, 101, 102], 'example 5')

unittest.main()
