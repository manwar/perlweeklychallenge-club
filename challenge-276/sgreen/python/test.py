#!/usr/bin/env python3

import unittest
ch_1 = __import__('ch-1')
ch_2 = __import__('ch-2')


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertEqual(ch_1.complete_day([12, 12, 30, 24, 24]), 2)
        self.assertEqual(ch_1.complete_day([72, 48, 24, 5]), 3)
        self.assertEqual(ch_1.complete_day([12, 18, 24]), 0)

    def test_ch_2(self):
        self.assertEqual(ch_2.maximum_frequency([1, 2, 2, 4, 1, 5]), 4)
        self.assertEqual(ch_2.maximum_frequency([1, 2, 3, 4, 5]), 5)


if __name__ == '__main__':
    unittest.main()
