#!/usr/bin/env python3

import unittest
ch_1 = __import__("ch-1")
ch_2 = __import__("ch-2")


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertEqual(ch_1.max_odd_binary("1011"), "1101")
        self.assertEqual(ch_1.max_odd_binary("100"), "001")
        self.assertEqual(ch_1.max_odd_binary("111000"), "110001")
        self.assertEqual(ch_1.max_odd_binary("0101"), "1001")
        self.assertEqual(ch_1.max_odd_binary("1111"), "1111")

    def test_ch_2(self):
        self.assertTrue(ch_2.conflict_events([("10:00", "12:00"), ("11:00", "13:00")]))
        self.assertFalse(ch_2.conflict_events([("09:00", "10:30"), ("10:30", "12:00")]))
        self.assertTrue(ch_2.conflict_events([("14:00", "15:30"), ("14:30", "16:00")]))
        self.assertFalse(ch_2.conflict_events([("08:00", "09:00"), ("09:01", "10:00")]))
        self.assertTrue(ch_2.conflict_events([("23:30", "00:30"), ("00:00", "01:00")]))


if __name__ == "__main__":
    unittest.main()
