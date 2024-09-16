#!/usr/bin/env python3

import unittest
ch_1 = __import__('ch-1')
ch_2 = __import__('ch-2')


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertEqual(ch_1.unique_number([3, 3, 1]), 1)
        self.assertEqual(ch_1.unique_number([3, 2, 4, 2, 4]), 3)
        self.assertEqual(ch_1.unique_number([1]), 1)
        self.assertEqual(ch_1.unique_number([4, 3, 1, 1, 1, 4]), 3)

    def test_ch_2(self):
        self.assertTrue(ch_2.digit_count_value([1, 2, 1, 0]))
        self.assertFalse(ch_2.digit_count_value([0, 3, 0]))


if __name__ == '__main__':
    unittest.main()
