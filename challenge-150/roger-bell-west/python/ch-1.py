#! /usr/bin/python3

import unittest

def fibstr(aa,bb,limit):
  a=aa
  b=bb
  while True:
    c=a+b
    print(c)
    if len(c) >= limit:
      return c[limit-1]
    a=b
    b=c

class TestFds(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(fibstr("1234","5678",51),"7",'example 1')

unittest.main()
