#!/usr/bin/env python3

import unittest
ch_1 = __import__("ch-1")
ch_2 = __import__("ch-2")


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertEqual(ch_1.finishing_order([3, 1, 4, 2, 5], [1, 2, 4]), [1, 4, 2])
        self.assertEqual(ch_1.finishing_order([5, 4, 3, 2, 1], [1, 3, 5]), [5, 3, 1])
        self.assertEqual(ch_1.finishing_order([2, 4, 1, 3], [1, 2, 3, 4]), [2, 4, 1, 3])
        self.assertEqual(ch_1.finishing_order([4, 1, 3, 2], [3]), [3])
        self.assertEqual(ch_1.finishing_order([1, 3, 2, 6, 5, 4], [1, 2, 3]), [1, 3, 2])

    def test_ch_2(self):
        self.assertEqual(ch_2.trionic_array([1, 3, 5, 4, 2, 6, 8]), True)
        self.assertEqual(ch_2.trionic_array([1, 4, 4, 2, 1, 3, 5]), False)
        self.assertEqual(ch_2.trionic_array([2, 10, 3, 1, 9]), True)
        self.assertEqual(ch_2.trionic_array([1, 2, 3, 4, 3, 2, 1]), False)
        self.assertEqual(ch_2.trionic_array([1, 3, 6, 4, 2, 7, 8, 4]), False)


if __name__ == "__main__":
    unittest.main()
