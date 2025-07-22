#!/usr/bin/env python3

import unittest
ch_1 = __import__('ch-1')
ch_2 = __import__('ch-2')


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertEqual(ch_1.last_word("The Weekly Challenge"), 9)
        self.assertEqual(ch_1.last_word("The Weekly Challenge!"), 9)
        self.assertEqual(ch_1.last_word("   Hello   World    "), 5)
        self.assertEqual(ch_1.last_word("Let's"), 5)
        self.assertEqual(ch_1.last_word("!!!"), 0)

    def test_ch_2(self):
        self.assertTrue(ch_2.buddy_strings("nice", "ncie"))
        self.assertFalse(ch_2.buddy_strings("love", "love"))
        self.assertTrue(ch_2.buddy_strings("feed", "feed"))


if __name__ == '__main__':
    unittest.main()
