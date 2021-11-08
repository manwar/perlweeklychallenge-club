#! /usr/bin/python3

import unittest

import re

def mr(n):
  fh=open(n,'r')
  f=set()
  p=re.compile(r"^([0-9]+)")
  while True:
    line=fh.readline()
    if not line:
      break
    m=p.match(line)
    f.add(int(m.group(1)))
  fh.close()
  a=1
  while True:
    if not(a in f):
      return a
    a+=1

class TestNs(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(mr("infile"),12,'example 1')
          
unittest.main()
