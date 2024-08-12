#!/usr/bin/env python3

import unittest
ch_1 = __import__('ch-1')
ch_2 = __import__('ch-2')


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertTrue(ch_1.check_color('d3'))
        self.assertFalse(ch_1.check_color('g5'))
        self.assertTrue(ch_1.check_color('e6'))

    def test_ch_2(self):
        self.assertEqual(ch_2.knights_move('g2', 'a8'), 4)
        self.assertEqual(ch_2.knights_move('g2', 'h2'), 3)


if __name__ == '__main__':
    unittest.main()
