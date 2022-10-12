#! /usr/bin/python3

import unittest

from itertools import chain

def ziplist(a, b):
  return list(chain(*zip(a,b)))

class TestZiplist(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(ziplist([1, 2, 3], ["a", "b", "c"]),
                           [1, "a", 2, "b", 3, "c"],
                           'example 1')

unittest.main()
