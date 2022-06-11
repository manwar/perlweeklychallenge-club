#! /usr/bin/python3

import unittest

import re
import string

def encrypt(kw,plaintext):
  return playfair(1,kw,plaintext)

def decrypt(kw,ciphertext):
  return playfair(-1,kw,ciphertext)

def posmod(a,b):
  m = a % b
  while m < 0:
    m += b
  return m

def stripnonalpha(src):
  bad = re.compile(r"[^a-z]+")
  out = bad.sub("",src.lower());
  j = re.compile(r"j")
  return j.sub("i",out);

def playfair(dir, kwi0, inp):
  kw = ""
  k = set()
  for c in stripnonalpha(kwi0 + string.ascii_lowercase):
    if not c in k:
      kw += c
      k.add(c)
  grid = []
  gc = dict()
  index = 0
  for row in range(5):
    r = []
    for column in range(5):
      r.append(kw[index])
      gc[kw[index]] = [row,column]
      index += 1
    grid.append(r)
  ii = stripnonalpha(inp)
  index = 0
  out = ""
  while index < len(ii):
    ca = ii[index]
    cb = "x"
    if index + 1 < len(ii):
      cb = ii[index+1]
    index += 2
    if ca == cb:
      cb = "x"
      index -= 1
    car,cac = gc[ca]
    cbr,cbc = gc[cb]
    oar,oac,obr,obc = car,cac,cbr,cbc
    if car == cbr:
      oac = posmod(cac + dir, 5)
      obc = posmod(cbc + dir, 5)
    elif cac == cbc:
      oar = posmod(car + dir, 5)
      obr = posmod(cbr + dir, 5)
    else:
      oac = cbc
      obc = cac
    out += grid[oar][oac] + grid[obr][obc]
  return out

class TestPlayfair(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(encrypt("playfair example",
                                   "hide the gold in the tree stump"),
                           "bmodzbxdnabekudmuixmmouvif",
                           'example 1')

        def test_ex2(self):
          self.assertEqual(decrypt("perl and raku",
                                   "siderwrdulfipaarkcrw"),
                           "thewexeklychallengex",
                           'example 2')

unittest.main()
