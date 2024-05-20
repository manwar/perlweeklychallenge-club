#!/usr/bin/env python3

import unittest
ch_1 = __import__('ch-1')
ch_2 = __import__('ch-2')


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertTrue(ch_1.bitwise_or([1, 2, 3, 4, 5]))
        self.assertTrue(ch_1.bitwise_or([2, 3, 8, 16]))
        self.assertFalse(ch_1.bitwise_or([1, 2, 5, 7, 9]))

    def test_ch_2(self):
        self.assertEqual(ch_2.distribute_elements([2, 1, 3, 4, 5]), [2, 3, 4, 5, 1])
        self.assertEqual(ch_2.distribute_elements([3, 2, 4]), [3, 4, 2])
        self.assertEqual(ch_2.distribute_elements([5, 4, 3 ,8]), [5, 3, 4, 8])


if __name__ == '__main__':
    unittest.main()
