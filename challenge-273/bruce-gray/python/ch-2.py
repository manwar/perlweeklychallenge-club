#!python
import re

def task2(str):
    p = re.compile('^[^b]*b[^a]*$')
    return bool(p.match(str))


import unittest
class TestTask1(unittest.TestCase):
    def t(self, str, expected):
        self.assertEqual(task2(str), expected, f"task2('{str}')")

    def test_1(self): self.t('aabb' , True )
    def test_2(self): self.t('abab' , False)
    def test_3(self): self.t('aaa'  , False)
    def test_4(self): self.t('bbb'  , True )

unittest.main()
