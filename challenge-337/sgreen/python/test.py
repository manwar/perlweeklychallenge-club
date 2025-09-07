#!/usr/bin/env python3

import unittest
ch_1 = __import__('ch-1')
ch_2 = __import__('ch-2')


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertEqual(ch_1.smaller_than_current([6, 5, 4, 8]), [2, 1, 0, 3])
        self.assertEqual(ch_1.smaller_than_current([7, 7, 7, 7]), [3, 3, 3, 3])
        self.assertEqual(ch_1.smaller_than_current([5, 4, 3, 2, 1]), [4, 3, 2, 1, 0])
        self.assertEqual(ch_1.smaller_than_current([-1, 0, 3, -2, 1]), [1, 2, 4, 0, 3])
        self.assertEqual(ch_1.smaller_than_current([0, 1, 1, 2, 0]), [1, 3, 3, 4, 1])

    def test_ch_2(self):
        self.assertEqual(ch_2.odd_matrix(2, 3, [[0,1],[1,1]]), 6)
        self.assertEqual(ch_2.odd_matrix(2, 2, [[1,1],[0,0]]), 0)
        self.assertEqual(ch_2.odd_matrix(3, 3, [[0,0],[1,2],[2,1]]), 0)
        self.assertEqual(ch_2.odd_matrix(1, 5, [[0,2],[0,4]]), 2)
        self.assertEqual(ch_2.odd_matrix(4, 2, [[1,0],[3,1],[2,0],[0,1]]), 8)


if __name__ == '__main__':
    unittest.main()
