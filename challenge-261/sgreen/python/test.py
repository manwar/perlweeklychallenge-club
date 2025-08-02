#!/usr/bin/env python3

import unittest
ch_1 = __import__('ch-1')
ch_2 = __import__('ch-2')


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertEqual(ch_1.element_digit_sum([1, 2, 3, 45]), 36)
        self.assertEqual(ch_1.element_digit_sum([1, 12, 3]), 9)
        self.assertEqual(ch_1.element_digit_sum([1, 2, 3, 4]), 0)
        self.assertEqual(ch_1.element_digit_sum([236, 416, 336, 350]), 1296)

    def test_ch_2(self):
        self.assertEqual(ch_2.multiple_by_two([5, 3, 6, 1, 12], 3), 24)
        self.assertEqual(ch_2.multiple_by_two([1, 2, 4, 3], 1), 8)
        self.assertEqual(ch_2.multiple_by_two([5, 6, 7], 2), 2)


if __name__ == '__main__':
    unittest.main()
