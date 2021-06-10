#! /usr/bin/python3

import re

def ng(name):
    tail=re.sub(r"^[bcdfghjklmnpqrstvwxz]*",'',name,flags=re.IGNORECASE)
    if name == tail:
        tail=tail.lower()
    return f"{name}, {name}, bo-b{tail}\nBonana-fanna fo-f{tail}\nFee fi mo-m{tail}\n{name}!"

import unittest

class TestNg(unittest.TestCase):

        def test_ex1(self):
            self.assertEqual(ng('Katie'),"Katie, Katie, bo-batie\nBonana-fanna fo-fatie\nFee fi mo-matie\nKatie!",'example 1')

        def test_ex2(self):
            self.assertEqual(ng('Anna'),"Anna, Anna, bo-banna\nBonana-fanna fo-fanna\nFee fi mo-manna\nAnna!",'example 2')

unittest.main()
