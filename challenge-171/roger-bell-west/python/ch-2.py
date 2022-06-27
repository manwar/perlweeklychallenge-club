#! /usr/bin/python3

import unittest

def compose(f1,f2):
  return lambda x: f1(f2(x))

class TestCompose(unittest.TestCase):

        def test_ex1(self):
          f = lambda x: x + 1
          g = lambda x: x * 2
          h = compose(f,g)
          for i in range(1,11):
            self.assertEqual(f(g(i)),h(i),'example 1')

unittest.main()
