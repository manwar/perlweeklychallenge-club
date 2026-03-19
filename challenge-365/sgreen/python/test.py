#!/usr/bin/env python3

import unittest
ch_1 = __import__("ch-1")
ch_2 = __import__("ch-2")


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertEqual(ch_1.aid_sum("abc", 1), 6)
        self.assertEqual(ch_1.aid_sum("az", 2), 9)
        self.assertEqual(ch_1.aid_sum("cat", 1), 6)
        self.assertEqual(ch_1.aid_sum("dog", 2), 8)
        self.assertEqual(ch_1.aid_sum("perl", 3), 6)

    def test_ch_2(self):
        self.assertEqual(ch_2.valid_token_counter("cat and dog"), 3)
        self.assertEqual(ch_2.valid_token_counter("a-b c! d,e"), 2)
        self.assertEqual(ch_2.valid_token_counter("hello-world! this is fun"), 4)
        self.assertEqual(ch_2.valid_token_counter("ab- cd-ef gh- ij!"), 2)
        self.assertEqual(ch_2.valid_token_counter("wow! a-b-c nice."), 2)


if __name__ == "__main__":
    unittest.main()
