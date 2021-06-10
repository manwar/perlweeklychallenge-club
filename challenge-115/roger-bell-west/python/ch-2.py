#! /usr/bin/python3

import unittest

def lm(*n):
  o=list(n)
  o.sort()
  ff=[i for i in range(len(o)) if o[i] % 2 == 0]
  if len(ff)==0:
    return 0
  i=ff[0]
  ox=list()
  ox.append(o[i])
  if i>0:
    for j in range(i):
      ox.append(o[j])
  if i+1<len(o):
    for j in range(i+1,len(o)):
      ox.append(o[j])
  ox.reverse()
  return int(''.join(str(i) for i in ox))

class TestSc(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(lm(1,0,2,6),6210,"example 1")
  
        def test_ex2(self):
          self.assertEqual(lm(1,4,2,8),8412,"example 2")
  
        def test_ex3(self):
          self.assertEqual(lm(4,1,7,6),7614,"example 3")
  
        def test_ex4(self):
          self.assertEqual(lm(1,3,5,7),0,"example 4")

unittest.main()
