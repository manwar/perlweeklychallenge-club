#!/usr/bin/env python3

import unittest
ch_1 = __import__('ch-1')
ch_2 = __import__('ch-2')


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertEqual(ch_1.longest_parenthesis('(()())'), 6)
        self.assertEqual(ch_1.longest_parenthesis(')()())'), 4)
        self.assertEqual(ch_1.longest_parenthesis('((()))()(((()'), 8)
        self.assertEqual(ch_1.longest_parenthesis('))))((()('), 2)
        self.assertEqual(ch_1.longest_parenthesis('()(()'), 2)

    def test_ch_2(self):
        self.assertEqual(ch_2.magic_expression(123, 6), ["1+2+3", "1*2*3"])
        self.assertEqual(ch_2.magic_expression(105, 5), ["10-5", "1*0+5"])
        self.assertEqual(ch_2.magic_expression(232, 8), ["2+3*2", "2*3+2"])
        self.assertEqual(ch_2.magic_expression(1234, 10), ["1+2+3+4", "1*2*3+4"])
        self.assertEqual(
            ch_2.magic_expression(1001, 2),
            ['1+0+0+1', '1+0-0+1', '1+0*0+1', '1-0+0+1', '1-0-0+1', '1-0*0+1']
        )


if __name__ == '__main__':
    unittest.main()
