#!/usr/bin/env python3

import unittest
ch_1 = __import__('ch-1')
ch_2 = __import__('ch-2')


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertEqual(ch_1.day_of_year('2025-02-02'), 33)
        self.assertEqual(ch_1.day_of_year('2025-04-10'), 100)
        self.assertEqual(ch_1.day_of_year('2025-09-07'), 250)

    def test_ch_2(self):
        self.assertEqual(ch_2.decompressed_list([1, 3, 2, 4]), [3, 4, 4])
        self.assertEqual(ch_2.decompressed_list([1, 1, 2, 2]), [1, 2, 2])
        self.assertEqual(ch_2.decompressed_list([3, 1, 3, 2]), [1, 1, 1, 2, 2, 2])


if __name__ == '__main__':
    unittest.main()
