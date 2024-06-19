#!/usr/bin/env python3

import unittest
ch_1 = __import__('ch-1')
ch_2 = __import__('ch-2')


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertEqual(ch_1.char_percentage('perl', 'e'), 25)
        self.assertEqual(ch_1.char_percentage('java', 'a'), 50)
        self.assertEqual(ch_1.char_percentage('python', 'm'), 0)
        self.assertEqual(ch_1.char_percentage('ada', 'a'), 67)
        self.assertEqual(ch_1.char_percentage('ballerina', 'l'), 22)
        self.assertEqual(ch_1.char_percentage('analitik', 'k'), 13)

    def test_ch_2(self):
        self.assertTrue(ch_2.b_after_a('aabb'))
        self.assertFalse(ch_2.b_after_a('abab'))
        self.assertFalse(ch_2.b_after_a('aaa'))
        self.assertTrue(ch_2.b_after_a('bbb'))


if __name__ == '__main__':
    unittest.main()
