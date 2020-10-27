#! /usr/bin/python3

import unittest

import struct

def ri(s):
    a=str(s)[::-1]
    if (a[-1] == '-'):
        a='-' + a[0:-1]
    a=int(a)
    try:
      b=struct.pack('<l',a)
    except struct.error as err:
        return 0
    return a

class TestRi(unittest.TestCase):

    def test_ex1(self):
        self.assertEqual(ri(1234),4321,'example 1')

    def test_ex2(self):
        self.assertEqual(ri(-1234),-4321,'example 2')

    def test_ex3(self):
        self.assertEqual(ri(1231230512),0,'example 3')

unittest.main()
