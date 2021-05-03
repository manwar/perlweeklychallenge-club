#! /usr/bin/python3

import unittest

def sm(matrix,search):
  f=0
  for row in matrix:
    if row[0] <= search:
      if row[len(row)-1] >= search:
        if search in row:
          f=1
        break
    else:
      break
  return f

class TestSm(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(sm([[  1,  2,  3,  5,  7 ],
                               [  9, 11, 15, 19, 20 ],
                               [ 23, 24, 25, 29, 31 ],
                               [ 32, 33, 39, 40, 42 ],
                               [ 45, 47, 48, 49, 50 ]],35),0,'example 1');

        def test_ex2(self):
          self.assertEqual(sm([[  1,  2,  3,  5,  7 ],
                               [  9, 11, 15, 19, 20 ],
                               [ 23, 24, 25, 29, 31 ],
                               [ 32, 33, 39, 40, 42 ],
                               [ 45, 47, 48, 49, 50 ]],39),1,'example 2');

unittest.main()
