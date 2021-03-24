#! /usr/bin/python3

def nroot(n,a):
    xk=2
    while 1:
        xk1=((n-1)*xk+a/(xk ** (n-1)))/n
        if xk1==xk:
            break
        xk=xk1
    return xk

import unittest

class TestNg(unittest.TestCase):

        def test_ex1(self):
            self.assertEqual(nroot(5,248832),12,'example 1')

        def test_ex2(self):
            self.assertEqual(nroot(5,34),34**0.2,'example 2')

unittest.main()
