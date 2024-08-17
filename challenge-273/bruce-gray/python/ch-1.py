#!python
import math
def lround(n):
    return math.floor(n + 0.5)

def task1(str, char):
    return lround(100 * str.count(char) / len(str))


import unittest
class TestTask1(unittest.TestCase):
    def t(self, str, char, expected):
        self.assertEqual(task1(str, char), expected, f"task1('{str}', '{char}')")

    def test_1(self): self.t('perl'      , 'e', 25)
    def test_2(self): self.t('java'      , 'a', 50)
    def test_3(self): self.t('python'    , 'm',  0)
    def test_4(self): self.t('ada'       , 'a', 67)
    def test_5(self): self.t('ballerina' , 'l', 22)
    def test_6(self): self.t('analitik'  , 'k', 13)

unittest.main()
