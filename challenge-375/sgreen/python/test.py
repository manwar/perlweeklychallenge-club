#!/usr/bin/env python3

import unittest
ch_1 = __import__("ch-1")
ch_2 = __import__("ch-2")


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertEqual(
            ch_1.single_common_word(
                ["apple", "banana", "cherry"],
                ["banana", "cherry", "date"]
            ),
            2
        )
        self.assertEqual(
            ch_1.single_common_word(["a", "ab", "abc"], ["a", "a", "ab", "abc"]),
            2
        )
        self.assertEqual(
            ch_1.single_common_word(["orange", "lemon"], ["grape", "melon"]),
            0
        )
        self.assertEqual(
            ch_1.single_common_word(
                ["test", "test", "demo"],
                ["test", "demo", "demo"]
            ),
            0
        )
        self.assertEqual(
            ch_1.single_common_word(["Hello", "world"], ["hello", "world"]),
            1
        )

    def test_ch_2(self):
        self.assertEqual(ch_2.k_beauty(240, 2), 2)
        self.assertEqual(ch_2.k_beauty(1020, 2), 3)
        self.assertEqual(ch_2.k_beauty(444, 2), 0)
        self.assertEqual(ch_2.k_beauty(17, 2), 1)
        self.assertEqual(ch_2.k_beauty(123, 1), 2)


if __name__ == "__main__":
    unittest.main()
