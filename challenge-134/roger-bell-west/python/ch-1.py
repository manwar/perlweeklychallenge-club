#! /usr/bin/python3

import unittest

from itertools import permutations

def pandigital(count):
  digits=1
  cc=1
  while cc<count:
    digits += 1
    cc *= digits
    if digits > 10:
      print("too large")
      return []
  template=[*range(9,1,-1),0,1]
  lead=template[digits:]
  lead.reverse()
  l="".join(str(i) for i in lead)
  template=template[0:digits]
  o=[]
  for p in permutations(template):
    o.append("".join(str(i) for i in p))
  o.sort()
  o=o[0:count]
  return [int(l+i) for i in o]

class TestIsqrt(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(pandigital(10),[1023456789, 1023456798, 1023456879, 1023456897, 1023456978, 1023456987, 1023457689, 1023457698, 1023457869, 1023457896],'example 1')

unittest.main()
