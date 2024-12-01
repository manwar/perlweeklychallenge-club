#!/usr/bin/env python3

import unittest
ch_1 = __import__('ch-1')
ch_2 = __import__('ch-2')


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertEqual(ch_1.contiguous_array([1, 0]), 2)
        self.assertEqual(ch_1.contiguous_array([0, 1, 0]), 2)
        self.assertEqual(ch_1.contiguous_array([0, 0, 0, 0, 0]), 0)
        self.assertEqual(ch_1.contiguous_array([0, 1, 0, 0, 1, 0]), 4)

    def test_ch_2(self):
        self.assertEqual(ch_2.semi_ordered_permutation([2, 1, 4, 3]), 2)
        self.assertEqual(ch_2.semi_ordered_permutation([2, 4, 1, 3]), 3)
        self.assertEqual(ch_2.semi_ordered_permutation([1, 3, 2, 4, 5]), 0)


if __name__ == '__main__':
    unittest.main()
