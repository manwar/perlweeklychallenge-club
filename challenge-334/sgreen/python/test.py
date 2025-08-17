#!/usr/bin/env python3

import unittest
ch_1 = __import__('ch-1')
ch_2 = __import__('ch-2')


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertEqual(ch_1.range_sum([-2, 0, 3, -5, 2, -1], 0, 2), 1)
        self.assertEqual(ch_1.range_sum([1, -2, 3, -4, 5], 1, 3), -3)
        self.assertEqual(ch_1.range_sum([1, 0, 2, -1, 3], 3, 4), 2)
        self.assertEqual(ch_1.range_sum([-5, 4, -3, 2, -1, 0], 0, 3), -2)
        self.assertEqual(ch_1.range_sum([-1, 0, 2, -3, -2, 1], 0, 2), 1)

    def test_ch_2(self):
        self.assertEqual(ch_2.shortest_index(3, 4, [[1, 2], [3, 1], [2, 4], [2, 3]]), 2)
        self.assertEqual(ch_2.shortest_index(2, 5, [[3, 4], [2, 3], [1, 5], [2, 5]]), 3)
        self.assertEqual(ch_2.shortest_index(1, 1, [[2, 2], [3, 3], [4, 4]]), -1)
        self.assertEqual(ch_2.shortest_index(0, 0, [[0, 1], [1, 0], [0, 2], [2, 0]]), 0)
        self.assertEqual(ch_2.shortest_index(5, 5, [[5, 6], [6, 5], [5, 4], [4, 5]]), 0)


if __name__ == '__main__':
    unittest.main()
