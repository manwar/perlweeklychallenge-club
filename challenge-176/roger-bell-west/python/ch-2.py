#! /usr/bin/python3

import unittest

def reversible(mx):
  o = []
  for n in range(1,mx+1):
    t = n + int(str(n)[::-1])
    q = True
    while t > 0:
      if t % 2 == 0:
        q = False
        break
      t //= 10
    if q:
      o.append(n)
  return o

class TestReversible(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(reversible(99),
                           [ 10, 12, 14, 16, 18, 21, 23, 25, 27, 30,
                             32, 34, 36, 41, 43, 45, 50, 52, 54, 61,
                             63, 70, 72, 81, 90 ],
                           'example 1')
 
unittest.main()
