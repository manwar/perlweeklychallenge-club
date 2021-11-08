#! /usr/bin/python3

import unittest

def sumofdigits(kk):
  s=int(0)
  for k in kk:
    l=int(k)
    while (l>0):
      s+=l % 10
      l = int(l/10)
  return s

def factor(nn):
  f=[]
  ft=2
  n=nn
  while n>1:
    dm=divmod(n,ft)
    if dm[1] == 0:
      f.append(ft)
      n = dm[0]
    else:
      ft += 1
      if ft % 2 == 0:
        ft += 1
  return f

def smith(ccount):
  lcount=ccount
  o=[]
  c=1
  while (1):
    c += 1
    ff=factor(c)
    if len(ff)==1:
      continue
    if sumofdigits([c])==sumofdigits(ff):
      o.append(c)
      lcount -= 1
      if lcount<=0:
        break
  return o

class TestSmith(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(smith(10),[4, 22, 27, 58, 85, 94, 121, 166, 202, 265],'example 1')

unittest.main()
