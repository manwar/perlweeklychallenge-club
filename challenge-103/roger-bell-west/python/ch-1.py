#! /usr/bin/python3

def cz(yy):
    y=int(yy)
    if y<0:
        y += 1
    y %= 60
    while y<0:
        y += 60
    return " ".join([['Metal','Water','Wood','Fire','Earth'][int(y/2)%5],['Monkey','Rooster','Dog','Pig','Rat','Water Buffalo','Tiger','Cat','Dragon','Snake','Horse','Goat'][y%12]])

import unittest

class TestCz(unittest.TestCase):

        def test_ex1(self):
            self.assertEqual(cz(2017),'Fire Rooster','example 1')

        def test_ex2(self):
            self.assertEqual(cz(1938),'Earth Tiger','example 2')

unittest.main()
