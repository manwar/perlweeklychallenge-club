#! /usr/bin/python3

import unittest

def p(y):
  return (y+int(y/4)-int(y/100)+int(y/400)) % 7

def longyear():
  return [y for y in range(1900,2100+1) if p(y-1)==3 or p(y)==4]

class TestLongyear(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(longyear(),[1903, 1908, 1914, 1920, 1925,
                                       1931, 1936, 1942, 1948, 1953,
                                       1959, 1964, 1970, 1976, 1981,
                                       1987, 1992, 1998, 2004, 2009,
                                       2015, 2020, 2026, 2032, 2037,
                                       2043, 2048, 2054, 2060, 2065,
                                       2071, 2076, 2082, 2088, 2093,
                                       2099],'example 1')

unittest.main()
