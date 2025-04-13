#!/usr/bin/env python3

import unittest
ch_1 = __import__('ch-1')
ch_2 = __import__('ch-2')


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertTrue(ch_1.circular(["perl", "loves", "scala"]))
        self.assertFalse(ch_1.circular(["love", "the", "programming"]))
        self.assertTrue(ch_1.circular(["java", "awk", "kotlin", "node.js"]))

    def test_ch_2(self):
        self.assertTrue(ch_2.subsequence("uvw", "bcudvew"))
        self.assertFalse(ch_2.subsequence("aec", "abcde"))
        self.assertTrue(ch_2.subsequence("sip", "javascript"))


if __name__ == '__main__':
    unittest.main()
