#!/usr/bin/env python3

import unittest
ch_1 = __import__('ch-1')
ch_2 = __import__('ch-2')


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertEqual(ch_1.count_even_digits([10, 1, 111, 24, 1000]), 3)
        self.assertEqual(ch_1.count_even_digits([111, 1, 11111]), 0)
        self.assertEqual(ch_1.count_even_digits([2, 8, 1024, 256]), 1)

    def test_ch_2(self):
        self.assertEqual(ch_2.sum_of_values([2, 5, 9, 11, 3], 1), 17)
        self.assertEqual(ch_2.sum_of_values([2, 5, 9, 11, 3], 2), 11)
        self.assertEqual(ch_2.sum_of_values([2, 5, 9, 11, 3], 0), 2)


if __name__ == '__main__':
    unittest.main()
