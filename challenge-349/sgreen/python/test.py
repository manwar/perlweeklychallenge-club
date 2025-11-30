#!/usr/bin/env python3

import unittest
ch_1 = __import__('ch-1')
ch_2 = __import__('ch-2')


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertEqual(ch_1.power_string('textbook'), 2)
        self.assertEqual(ch_1.power_string('aaaaa'), 5)
        self.assertEqual(ch_1.power_string('hoorayyy'), 3)
        self.assertEqual(ch_1.power_string('x'), 1)
        self.assertEqual(ch_1.power_string('aabcccddeeffffghijjk'), 4)

    def test_ch_2(self):
        self.assertFalse(ch_2.meeting_point('ULD'))
        self.assertTrue(ch_2.meeting_point('ULDR'))
        self.assertFalse(ch_2.meeting_point('UUURRRDDD'))
        self.assertTrue(ch_2.meeting_point('UURRRDDLLL'))
        self.assertTrue(ch_2.meeting_point('RRUULLDDRRUU'))


if __name__ == '__main__':
    unittest.main()
