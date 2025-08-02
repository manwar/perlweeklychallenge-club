#!/usr/bin/env python3

import unittest
ch_1 = __import__('ch-1')
ch_2 = __import__('ch-2')


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertEqual(ch_1.max_type([-3, 1, 2, -1, 3, -2, 4]), 4)
        self.assertEqual(ch_1.max_type([-1, -2, -3, 1]), 3)
        self.assertEqual(ch_1.max_type([1,2]), 2)

    def test_ch_2(self):
        self.assertEqual(ch_2.equal_div([3, 1, 2, 2, 2, 1, 3], 2), 4)
        self.assertEqual(ch_2.equal_div([1, 2, 3], 1), 0)


if __name__ == '__main__':
    unittest.main()
