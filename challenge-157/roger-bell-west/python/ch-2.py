#! /usr/bin/python3

import unittest

def brazilian(n):
  for b in range(2,n-1):
    nn = n
    braz = True
    digit = nn % b
    while nn > 0:
      if digit == nn % b:
        nn //= b
      else:
        braz = False
        break
    if braz:
      return True
  return False
    
class TestBrazilian(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(brazilian(7),True,'example 1')

        def test_ex2(self):
          self.assertEqual(brazilian(6),False,'example 2')

        def test_ex3(self):
          self.assertEqual(brazilian(8),True,'example 3')

unittest.main()
