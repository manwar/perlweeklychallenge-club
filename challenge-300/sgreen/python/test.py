#!/usr/bin/env python3

import unittest
ch_1 = __import__('ch-1')
ch_2 = __import__('ch-2')


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertEqual(ch_1.beautiful_arrangement(2), 2)
        self.assertEqual(ch_1.beautiful_arrangement(1), 1)
        self.assertEqual(ch_1.beautiful_arrangement(10), 700)

    def test_ch_2(self):
        self.assertEqual(ch_2.nested_array([5, 4, 0, 3, 1, 6, 2]), 4)
        self.assertEqual(ch_2.nested_array([0, 1, 2]), 1)
        self.assertEqual(ch_2.nested_array([1, 2, 0, 4, 5, 2]), 5)


if __name__ == '__main__':
    unittest.main()
