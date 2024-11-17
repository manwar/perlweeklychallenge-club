#!/usr/bin/env python3

import unittest
ch_1 = __import__('ch-1')
ch_2 = __import__('ch-2')


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertTrue(ch_1.word_break(
            'weeklychallenge', ["challenge", "weekly"]))
        self.assertTrue(ch_1.word_break('perlrakuperl', ["raku", "perl"]))
        self.assertFalse(ch_1.word_break(
            'sonsanddaughters', ["sons", "sand", "daughters"]))

    def test_ch_2(self):
        self.assertEqual(ch_2.jump_game([2, 3, 1, 1, 4]), 2)
        self.assertEqual(ch_2.jump_game([2, 3, 0, 4]), 2)
        self.assertEqual(ch_2.jump_game([2, 0, 0, 4]), None)


if __name__ == '__main__':
    unittest.main()
