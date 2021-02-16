#! /usr/bin/python3

import re

def ft(i):
    m=re.match('(\d+):(\d+)\s*([ap]m)?',i)
    h=int(m.group(1))
    t=""
    if m.group(3) == None:
        t=" am"
        if h > 11:
            t = " pm"
            h -= 12
        if h==0:
            h=12
    else:
        if h==12:
            h=0
        if m.group(3) == "pm":
            h += 12
    return "{:02d}:{:02d}{:s}".format(h,int(m.group(2)),t)

import unittest

class TestFt(unittest.TestCase):

        def test_ex1(self):
            self.assertEqual(ft('05:15 pm'),'17:15','example 1')

        def test_ex2(self):
            self.assertEqual(ft('05:15 pm'),'17:15','example 2')

        def test_ex3(self):
            self.assertEqual(ft('19:15'),'07:15 pm','example 3')

        def test_ex4(self):
            self.assertEqual(ft('00:00'),'12:00 am','example 4')

        def test_ex5(self):
            self.assertEqual(ft('12:00'),'12:00 pm','example 5')

        def test_ex6(self):
            self.assertEqual(ft('12:00 am'),'00:00','example 6')

        def test_ex7(self):
            self.assertEqual(ft('12:00 pm'),'12:00','example 7')

unittest.main()
