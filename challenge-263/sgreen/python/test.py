#!/usr/bin/env python3

import unittest
ch_1 = __import__('ch-1')
ch_2 = __import__('ch-2')


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertEqual(ch_1.target_index([1, 5, 3, 2, 4, 2], 2), [1, 2])
        self.assertEqual(ch_1.target_index([1, 2, 4, 3, 5], 6), [])
        self.assertEqual(ch_1.target_index([5, 3, 2, 4, 2, 1], 4), [4])

    def test_ch_2(self):
        self.assertEqual(
            ch_2.merge_items([[1, 1], [2, 1], [3, 2]], [[2, 2], [1, 3]]),
            [[1, 4], [2, 3], [3, 2]]
        )
        self.assertEqual(
            ch_2.merge_items([[1, 2], [2, 3], [1, 3], [3, 2]], [[3, 1], [1, 3]]),
            [[1, 8], [2, 3], [3, 3]]
        )
        self.assertEqual(
            ch_2.merge_items([[1, 1], [2, 2], [3, 3]], [[2, 3], [2, 4]]),
            [[1, 1], [2, 9], [3, 3]]
        )


if __name__ == '__main__':
    unittest.main()
