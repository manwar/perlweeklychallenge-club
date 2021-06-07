#! /usr/bin/python3

import unittest

def ns(n):
  ns=str(n)
  l=len(ns)
  for sl in range(1,int(l/2)+1):
    i=sl
    e=[int(ns[0:sl])]
    while 1:
      if l-i==0:
        break
      e.append(e[-1]+1)
      es=str(e[-1])
      el=len(es)
      if l-i < el or ns[i:i+el] != es:
        e=[]
        break
      i+=el
    if len(e)>0:
      return e
  return [n]

class TestNs(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(ns(1234),[1,2,3,4],'example 1')
          
        def test_ex2(self):
          self.assertEqual(ns(91011),[9,10,11],'example 2')

        def test_ex3(self):
          self.assertEqual(ns(10203),[10203],'example 3')
          
        def test_ex4(self):
          self.assertEqual(ns(910911),[910,911],'example 4')

        def test_ex5(self):
          self.assertEqual(ns(9109119),[9109119],'example 4')

unittest.main()
