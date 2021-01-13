#! /usr/bin/python3

import re

def cn(n):
    m=re.findall(r'((.)\2*)',n)
    out=list()
    for mch in m:
        out.append(str(len(mch[0])))
        out.append(mch[1])
    return ''.join(out)

import unittest

class TestCn(unittest.TestCase):

    def test_ex1(self):
        self.assertEqual(cn('1122234'),'21321314','example 1');

    def test_ex2(self):
        self.assertEqual(cn('2333445'),'12332415','example 2');

    def test_ex3(self):
        self.assertEqual(cn('12345'),'1112131415','example 3');

unittest.main()
