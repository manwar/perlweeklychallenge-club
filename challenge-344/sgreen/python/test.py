#!/usr/bin/env python3

import unittest
ch_1 = __import__('ch-1')
ch_2 = __import__('ch-2')


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertEqual(ch_1.array_form_compute([1, 2, 3, 4], 12), [1, 2, 4, 6])
        self.assertEqual(ch_1.array_form_compute([2, 7, 4], 181), [4, 5, 5])
        self.assertEqual(ch_1.array_form_compute([9, 9, 9], 1), [1, 0, 0, 0])
        self.assertEqual(ch_1.array_form_compute([1, 0 ,0, 0, 0], 9999), [1, 9, 9, 9, 9])
        self.assertEqual(ch_1.array_form_compute([0], 1000), [1, 0, 0, 0])

    def test_ch_2(self):
        self.assertTrue(ch_2.array_formation([[2,3], [1], [4]], [1, 2, 3, 4]))
        self.assertFalse(ch_2.array_formation([[1,3], [2,4]], [1, 2, 3, 4]))
        self.assertTrue(ch_2.array_formation([[9,1], [5,8], [2]], [5, 8, 2, 9, 1]))
        self.assertFalse(ch_2.array_formation([[1], [3]], [1, 2, 3]))
        self.assertTrue(ch_2.array_formation([[7,4,6]], [7,4,6]))


if __name__ == '__main__':
    unittest.main()
