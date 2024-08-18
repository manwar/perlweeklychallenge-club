#!/usr/bin/env python3

import unittest
ch_1 = __import__('ch-1')
ch_2 = __import__('ch-2')


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertEqual(ch_1.good_integer(12344456), '444')
        self.assertEqual(ch_1.good_integer(1233334), '-1')
        self.assertEqual(ch_1.good_integer(10020003), '000')

    def test_ch_2(self):
        self.assertEqual(ch_2.key_changes('pPeERrLl'), 3)
        self.assertEqual(ch_2.key_changes('rRr'), 0)
        self.assertEqual(ch_2.key_changes('GoO'), 1)


if __name__ == '__main__':
    unittest.main()
