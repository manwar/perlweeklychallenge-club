#! /usr/bin/python3

import unittest

def wl(s):
    a=s.split()
    return len(''.join(a[1:len(a)-1]))

class TestWl(unittest.TestCase):

    def test_ex1(self):
        self.assertEqual(wl('The Weekly Challenge'),6,'example 1')

    def test_ex2(self):
        self.assertEqual(wl('The purpose of our lives is to be happy'),23,'example 2')

unittest.main()
