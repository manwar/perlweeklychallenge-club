#!/usr/bin/env python3

import unittest
ch_1 = __import__('ch-1')
ch_2 = __import__('ch-2')


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        result_1 = [102, 120, 130, 132, 210, 230, 302, 310, 312, 320]
        self.assertEqual(ch_1.three_digits_even([2, 1, 3, 0]), result_1)

        result_2 = [222, 228, 282, 288, 822, 828, 882]
        self.assertEqual(ch_1.three_digits_even([2, 2, 8, 8, 2]), result_2)

    def test_ch_2(self):
        self.assertEqual(ch_2.delete_and_earn([3, 4, 2]), 6)
        self.assertEqual(ch_2.delete_and_earn([2, 2, 3, 3, 3, 4]), 9)


if __name__ == '__main__':
    unittest.main()
