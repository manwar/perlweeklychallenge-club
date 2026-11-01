#! /usr/bin/python3

def reflect(a):
  p = []
  am = a
  while True:
    p.append(am % 2)
    am = am >> 1
    if am == 0:
      break
  ar = 0
  s = len(p)
  for n in p:
    s -= 1
    ar += n << s
  return ar

def binaryreflection(ax):
  k = [reflect(x) for x in ax]
  i = list(range(len(ax)))
  i.sort(key = lambda i: ax[i])
  i.sort(key = lambda i: k[i])
  return [ax[x] for x in i]
  
import unittest

class TestBinaryreflection(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(binaryreflection([3, 6, 12]), [3, 6, 12], 'example 1')

  def test_ex2(self):
    self.assertEqual(binaryreflection([1, 2, 4, 8]), [1, 2, 4, 8], 'example 2')

  def test_ex3(self):
    self.assertEqual(binaryreflection([7, 8, 9, 10]), [8, 10, 7, 9], 'example 3')

  def test_ex4(self):
    self.assertEqual(binaryreflection([5, 9, 15, 17]), [5, 9, 15, 17], 'example 4')

  def test_ex5(self):
    self.assertEqual(binaryreflection([11, 13, 14, 19]), [14, 13, 11, 19], 'example 5')

unittest.main()
