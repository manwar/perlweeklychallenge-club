#!/usr/bin/env python3

import unittest
ch_1 = __import__("ch-1")
ch_2 = __import__("ch-2")


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertEqual(ch_1.array_median([2], [4]), 3.0)
        self.assertEqual(ch_1.array_median([1,2,3], [7,8,9,10]), 7.0)
        self.assertEqual(ch_1.array_median([], [10,20,30,40]), 25.0)
        self.assertEqual(ch_1.array_median([100], [1,2,3,4,5,6,7]), 4.5)
        self.assertEqual(ch_1.array_median([1,2,2], [2,2,3]), 2.0)

    def test_ch_2(self):
        self.assertEqual(ch_2.arrange_box([1, 3], [3, 5], [6, 8], [2, 4]), 4)
        self.assertEqual(ch_2.arrange_box([4, 5], [4, 6], [6, 7], [2, 3], [4, 3]), 3)
        self.assertEqual(ch_2.arrange_box([5, 5], [5, 5], [5, 5]), 1)
        self.assertEqual(ch_2.arrange_box([2, 100], [3, 200], [4, 300], [5, 50], [5, 400]), 4)
        self.assertEqual(ch_2.arrange_box([10, 20], [15, 10], [20, 30], [12, 18], [16, 25]), 3)


if __name__ == "__main__":
    unittest.main()
