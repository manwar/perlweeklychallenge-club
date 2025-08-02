#!/usr/bin/env python3

import unittest
ch_1 = __import__('ch-1')
ch_2 = __import__('ch-2')


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertTrue(ch_1.is_acronyms(["Perl", "Weekly", "Challenge"], "PWC"))
        self.assertTrue(ch_1.is_acronyms(["Bob", "Charlie", "Joe"], "BCJ"))
        self.assertFalse(ch_1.is_acronyms(["Morning", "Good"], "MM"))

    def test_ch_2(self):
        self.assertTrue(ch_2.friendly_strings("desc", "dsec"))
        self.assertTrue(ch_2.friendly_strings("fcyn", "fcny"))
        self.assertFalse(ch_2.friendly_strings("poo", "eop"))
        self.assertTrue(ch_2.friendly_strings("stripe", "sprite"))
        self.assertTrue(ch_2.friendly_strings("bitter", "bitter"))
        self.assertFalse(ch_2.friendly_strings("biter", "biter"))


if __name__ == '__main__':
    unittest.main()
