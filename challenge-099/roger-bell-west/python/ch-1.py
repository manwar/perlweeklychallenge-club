#! /usr/bin/python3

import re

def pm(text,match):
    rl=list()
    rl.append("^")
    for c in match:
        if c == '?':
            rl.append(".")
        elif c == '*':
            rl.append(".*")
        else:
            rl.append(c)
    rl.append("$")
    rls=''.join(rl)
    if re.match(rls,text):
        return 1
    return 0
    
import unittest

class TestPm(unittest.TestCase):

    def test_ex1(self):
        self.assertEqual(pm('abcde','a*e'),1,'example 1')

    def test_ex2(self):
        self.assertEqual(pm('abcde','a*d'),0,'example 2')

    def test_ex3(self):
        self.assertEqual(pm('abcde','?b*d'),0,'example 3')

    def test_ex4(self):
        self.assertEqual(pm('abcde','a*c?e'),1,'example 4')

unittest.main()
