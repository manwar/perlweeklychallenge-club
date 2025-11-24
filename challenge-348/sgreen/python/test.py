#!/usr/bin/env python3

import unittest
ch_1 = __import__('ch-1')
ch_2 = __import__('ch-2')


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertFalse(ch_1.string_alike("textbook"))
        self.assertTrue(ch_1.string_alike("book"))
        self.assertTrue(ch_1.string_alike("AbCdEfGh"))
        self.assertFalse(ch_1.string_alike("rhythmmyth"))
        self.assertFalse(ch_1.string_alike("UmpireeAudio"))

    def test_ch_2(self):
        self.assertEqual(ch_2.convert_time("02:30", "02:45"), 1)
        self.assertEqual(ch_2.convert_time("11:55", "12:15"), 2)
        self.assertEqual(ch_2.convert_time("09:00", "13:00"), 4)
        self.assertEqual(ch_2.convert_time("23:45", "00:30"), 3)
        self.assertEqual(ch_2.convert_time("14:20", "15:25"), 2)


if __name__ == '__main__':
    unittest.main()
