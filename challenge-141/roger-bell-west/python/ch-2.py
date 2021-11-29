#! /usr/bin/python3

import unittest

def likenumber(source,factor):
  s=[int(i) for i in str(source)]
  m=len(s)
  n=0
  for mask in range(1,(1<<m)-1):
    c=0
    for di in range(m):
      if mask & 1<<di:
        c=c*10+s[di]
    if c % factor == 0:
      n+=1
  return n

class TestLikenumber(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(likenumber(1234,2),9,'example 1')

        def test_ex2(self):
          self.assertEqual(likenumber(768,4),3,'example 2')

unittest.main()
