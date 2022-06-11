#! /usr/bin/python3

import unittest

def fim(n0):
  words=["zero","one","two","three","four",
         "five","six","seven","eight","nine"]
  n=n0
  p=[]
  while True:
    s = words[n] + " is "
    if n==4:
      s += "magic."
      p.append(s)
      break
    else:
      n = len(words[n])
      s += words[n]
      p.append(s)
  return (", ".join(p)).capitalize()

class TestFim(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(fim(5),
                           "Five is four, four is magic.",
                           'example 1')

        def test_ex2(self):
          self.assertEqual(fim(7),
                           "Seven is five, five is four, four is magic.",
                           'example 2')

        def test_ex3(self):
          self.assertEqual(fim(6),
                           "Six is three, three is five, five is four, four is magic.",
                           'example 3')

        def test_ex4(self):
          self.assertEqual(fim(4),
                           "Four is magic.",
                           'example 4')

unittest.main()
