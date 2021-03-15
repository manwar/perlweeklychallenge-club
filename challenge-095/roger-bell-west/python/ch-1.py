#! /usr/bin/python3
import unittest

def pn(n):
    ns='{0}'.format(n)
    nr=ns[::-1]
    if (nr == ns):
        return 1
    else:
        return 0

class TestPn(unittest.TestCase):

    def test_ex1(self):
        self.assertEqual(pn(1221),1,'example 1');

    def test_ex2(self):
        self.assertEqual(pn(-101),0,'example 2');

    def test_ex3(self):
        self.assertEqual(pn(90),0,'example 3');

unittest.main()
