#!/usr/bin/env python3

import unittest
ch_1 = __import__('ch-1')


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertEqual(ch_1.middle_index([2, 3, -1, 8, 4]), 3)
        self.assertEqual(ch_1.middle_index([1, -1, 4]), 2)
        self.assertEqual(ch_1.middle_index([2, 5]), -1)


if __name__ == '__main__':
    unittest.main()
