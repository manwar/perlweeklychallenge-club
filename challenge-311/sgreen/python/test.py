#!/usr/bin/env python3

import unittest
ch_1 = __import__('ch-1')
ch_2 = __import__('ch-2')


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertEqual(ch_1.upper_lower('pERl'), 'PerL')
        self.assertEqual(ch_1.upper_lower('rakU'), 'RAKu')
        self.assertEqual(ch_1.upper_lower('PyThOn'), 'pYtHoN')

    def test_ch_2(self):
        self.assertEqual(ch_2.group_digit_sum('111122333', 3), 359)
        self.assertEqual(ch_2.group_digit_sum('1222312', 2), 76)
        self.assertEqual(ch_2.group_digit_sum('100012121001', 4), 162)


if __name__ == '__main__':
    unittest.main()
