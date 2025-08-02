#!/usr/bin/env python3

import unittest
ch_1 = __import__('ch-1')
ch_2 = __import__('ch-2')


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertEqual(ch_1.broken_keys('Perl Weekly Challenge', ['l', 'a']), 0)
        self.assertEqual(ch_1.broken_keys('Perl and Raku', ['a']), 1)
        self.assertEqual(ch_1.broken_keys('Well done Team PWC', ['l', 'o']), 2)
        self.assertEqual(ch_1.broken_keys('The joys of polyglottism', ['T']), 2)

    def test_ch_2(self):
        self.assertEqual(ch_2.replace_digits('a1c1e1'), 'abcdef')
        self.assertEqual(ch_2.replace_digits('a1b2c3d4'), 'abbdcfdh')
        self.assertEqual(ch_2.replace_digits('b2b'), 'bdb')
        self.assertEqual(ch_2.replace_digits('a16z'), 'abgz')


if __name__ == '__main__':
    unittest.main()
