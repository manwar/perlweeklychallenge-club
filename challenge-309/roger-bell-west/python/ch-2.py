#! /usr/bin/python3

def mindiff(a):
    md = 0
    n = False
    for i in range(len(a) - 1):
        for j in range(i + 1, len(a)):
            diff = abs(a[i] - a[j])
            if not n or diff < md:
                md = diff
                n = True
    return md

import unittest

class TestMindiff(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(mindiff([1, 5, 8, 9]), 1, 'example 1')

  def test_ex2(self):
    self.assertEqual(mindiff([9, 4, 1, 7]), 2, 'example 2')

unittest.main()
