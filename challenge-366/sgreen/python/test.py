#!/usr/bin/env python3

import unittest
ch_1 = __import__("ch-1")
ch_2 = __import__("ch-2")


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertEqual(ch_1.count_prefixes(["a", "ap", "app", "apple", "banana"], "apple"), 4)
        self.assertEqual(ch_1.count_prefixes(["cat", "dog", "fish"], "bird"), 0)
        self.assertEqual(ch_1.count_prefixes(["hello", "he", "hell", "heaven", "he"], "hello"), 4)
        self.assertEqual(ch_1.count_prefixes(["", "code", "coding", "cod"], "coding"), 3)
        self.assertEqual(ch_1.count_prefixes(["p", "pr", "pro", "prog", "progr", "progra", "program"], "program"), 7)

    def test_ch_2(self):
        self.assertEqual(ch_2.valid_times("?2:34"), 3)
        self.assertEqual(ch_2.valid_times("?4:?0"), 12)
        self.assertEqual(ch_2.valid_times("??:??"), 1440)
        self.assertEqual(ch_2.valid_times("?3:45"), 3)
        self.assertEqual(ch_2.valid_times("2?:15"), 4)


if __name__ == "__main__":
    unittest.main()
