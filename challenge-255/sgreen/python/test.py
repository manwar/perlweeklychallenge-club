#!/usr/bin/env python3

import unittest
ch_1 = __import__('ch-1')
ch_2 = __import__('ch-2')


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertEqual(ch_1.odd_character('Perl', 'Preel'), 'e')
        self.assertEqual(ch_1.odd_character('Weekly', 'Weeakly'), 'a')
        self.assertEqual(ch_1.odd_character('Box', 'Boxy'), 'y')

    def test_ch_2(self):
        self.assertEqual(ch_2.most_frequent_word('Joe hit a ball, the hit ball flew far after it was hit.', 'hit'), 'ball')
        self.assertEqual(ch_2.most_frequent_word('Perl and Raku belong to the same family. Perl is the most popular language in the weekly challenge.', 'the'), 'perl')


if __name__ == '__main__':
    unittest.main()
