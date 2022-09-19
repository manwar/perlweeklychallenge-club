#! /usr/bin/python3

import unittest

def permutable():
  n = 0
  while True:
    n += 1
    base = sorted(str(n))
    q = True
    for k in range(2,7):
      if sorted(str(n * k)) != base:
        q = False
        break
    if q:
      return n

class TestPermutable(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(permutable(),
                           142857,
                           'example 1')
 
unittest.main()
