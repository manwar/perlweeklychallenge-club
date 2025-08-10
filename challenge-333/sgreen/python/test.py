#!/usr/bin/env python3

import unittest
ch_1 = __import__('ch-1')
ch_2 = __import__('ch-2')


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertTrue(ch_1.straight_line([[2, 1], [2, 3], [2, 5]]))
        self.assertTrue(ch_1.straight_line([[1, 4], [3, 4], [10, 4]]))
        self.assertFalse(ch_1.straight_line([[0, 0], [1, 1], [2, 3]]))
        self.assertTrue(ch_1.straight_line([[1, 1], [1, 1], [1, 1]]))
        self.assertTrue(
            ch_1.straight_line(
                [[1000000, 1000000], [2000000, 2000000], [3000000, 3000000]]
            )
        )

    def test_ch_2(self):
        self.assertEqual(
            ch_2.duplicate_zeros([1, 0, 2, 3, 0, 4, 5, 0]),
            [1, 0, 0, 2, 3, 0, 0, 4]
        )
        self.assertEqual(ch_2.duplicate_zeros([1, 2, 3]), [1, 2, 3])
        self.assertEqual(ch_2.duplicate_zeros([1, 2, 3, 0]), [1, 2, 3, 0])
        self.assertEqual(ch_2.duplicate_zeros([0, 0, 1, 2]), [0, 0, 0, 0])
        self.assertEqual(ch_2.duplicate_zeros([1, 2, 0, 3, 4]), [1, 2, 0, 0, 3])


if __name__ == '__main__':
    unittest.main()
