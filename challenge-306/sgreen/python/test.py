#!/usr/bin/env python3

import unittest
ch_1 = __import__('ch-1')
ch_2 = __import__('ch-2')


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertEqual(ch_1.odd_sum([2, 5, 3, 6, 4]), 77)
        self.assertEqual(ch_1.odd_sum([1, 3]), 4)

    def test_ch_2(self):
        self.assertEqual(ch_2.last_element([3, 8, 5, 2, 9, 2]), 1)
        self.assertEqual(ch_2.last_element([3, 2, 5]), 0)


if __name__ == '__main__':
    unittest.main()
