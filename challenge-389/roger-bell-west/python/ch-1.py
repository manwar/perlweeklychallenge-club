#! /usr/bin/python3

def reordernotes(composer, notes, order):
  out = [""] * len(order)
  for i, n in enumerate(order):
    out[n - 1] = notes[i]
  return { composer : out }

import unittest

class TestReordernotes(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(reordernotes("Mozart", ["C", "D", "E", "F", "G", "A", "B"], [7, 1, 6, 2, 5, 3, 4]), {"Mozart": ["D", "F", "A", "B", "G", "E", "C"]}, 'example 1')

  def test_ex2(self):
    self.assertEqual(reordernotes("Chopin", ["C", "C#", "D", "D#", "E", "F"], [6, 5, 4, 3, 2, 1]), {"Chopin": ["F", "E", "D#", "D", "C#", "C"]}, 'example 2')

  def test_ex3(self):
    self.assertEqual(reordernotes("Vivaldi", ["A", "B", "C", "D", "E"], [1, 2, 3, 4, 5]), {"Vivaldi": ["A", "B", "C", "D", "E"]}, 'example 3')

  def test_ex4(self):
    self.assertEqual(reordernotes("Debussy", ["C", "D", "F", "G", "A"], [1, 3, 5, 2, 4]), {"Debussy": ["C", "G", "D", "A", "F"]}, 'example 4')

  def test_ex5(self):
    self.assertEqual(reordernotes("Stravinsky", ["C#"], [1]), {"Stravinsky": ["C#"]}, 'example 5')

unittest.main()
