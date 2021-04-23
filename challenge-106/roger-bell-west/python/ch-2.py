#! /usr/bin/python3

def ds(n,d):
    quotient=str(n // d) + '.'
    c=10*(n % d)
    while (c > 0 and c < d):
      c *= 10
      quotient += "0"
    digits=list()
    passed=dict()
    i=0
    while 1:
      if c in passed:
          cycle=digits[passed[c]:]
          result=quotient + ''.join(digits[0:passed[c]])
          if len(cycle)>1 or cycle[0] != '0':
              result += "(" + ''.join(cycle) + ")"
          return result.rstrip('.')
      q=c // d
      r=c % d
      passed[c]=i
      digits.append(str(q))
      i += 1
      c=10*r

import unittest

class TestDs(unittest.TestCase):

        def test_ex1(self):
            self.assertEqual(ds(1,3),"0.(3)",'example 1')

        def test_ex2(self):
            self.assertEqual(ds(1,2),"0.5",'example 2')

        def test_ex3(self):
            self.assertEqual(ds(5,66),"0.0(75)",'example 3')

unittest.main()
