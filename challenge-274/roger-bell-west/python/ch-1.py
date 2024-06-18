#! /usr/bin/python3

def goatlatin(a):
  out = []
  for ix, word in enumerate(a.split(" ")):
    nw = word
    match word[0].lower():
      case 'a' | 'e' | 'i' | 'o' | 'u':
        True
      case _:
        nw = word[1:]
        nw += word[0]
    nw += "ma"
    for i in range(ix + 1):
      nw += "a"
    out.append(nw)
  return " ".join(out)


import unittest

class TestGoatlatin(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(goatlatin("I love Perl"), "Imaa ovelmaaa erlPmaaaa", 'example 1')

  def test_ex2(self):
    self.assertEqual(goatlatin("Perl and Raku are friends"), "erlPmaa andmaaa akuRmaaaa aremaaaaa riendsfmaaaaaa", 'example 2')

  def test_ex3(self):
    self.assertEqual(goatlatin("The Weekly Challenge"), "heTmaa eeklyWmaaa hallengeCmaaaa", 'example 3')

unittest.main()
