#! /usr/bin/python

import unittest

def csb(tot):
    bits=0
    m=1000000007;
    for n in range(1,tot+1):
        bits += bin(n).count("1")
        bits %= m
    return bits

class TestCsb(unittest.TestCase):

    def test_ex1(self):
        self.assertEqual(csb(4),5,'example 1')

    def test_ex2(self):
        self.assertEqual(csb(3),4,'example 2')

unittest.main()
