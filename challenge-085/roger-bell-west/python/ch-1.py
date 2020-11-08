#! /usr/bin/python3

from itertools import combinations

def ts(*a):
    n=[x for x in a if x < 2]
    for b in combinations(n,3):
        s=sum(b)
        if (s > 1 and s < 2):
            return 1
    return 0

import unittest

class TestTs(unittest.TestCase):

    def test_ex1(self):
        self.assertEqual(ts(1.2, 0.4, 0.1, 2.5),1,'example 1')

    def test_ex2(self):
        self.assertEqual(ts(0.2, 1.5, 0.9, 1.1),0,'example 2')

    def test_ex3(self):
        self.assertEqual(ts(0.5, 1.1, 0.3, 0.7),1,'example 3')

unittest.main()
