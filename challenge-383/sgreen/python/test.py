#!/usr/bin/env python3

import unittest
ch_1 = __import__("ch-1")
ch_2 = __import__("ch-2")


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertTrue(ch_1.similar_list(
            ["great", "acting"],
            ["fine", "drama"],
            [["great", "fine"], ["acting", "drama"]]
        ))
        self.assertFalse(ch_1.similar_list(
            ["apple", "pie"],
            ["banana", "pie"],
            [["apple", "peach"], ["peach", "banana"]]
        ))
        self.assertTrue(ch_1.similar_list(
            ["perl4", "python"],
            ["raku", "python"],
            [["perl4", "perl5", "raku"]]
        ))
        self.assertFalse(ch_1.similar_list(
            ["enjoy", "challenge"],
            ["love", "weekly", "challenge"],
            [["enjoy", "love"]]
        ))
        self.assertTrue(ch_1.similar_list(
            ["fast", "car"],
            ["quick", "vehicle"],
            [["quick", "fast"], ["vehicle", "car"]]
        ))

    def test_ch_2(self):
        self.assertEqual(ch_2.nearest_rgb("#F4B2D1"), "#FF99CC")
        self.assertEqual(ch_2.nearest_rgb("#15E6E5"), "#00FFCC")
        self.assertEqual(ch_2.nearest_rgb("#191A65"), "#003366")
        self.assertEqual(ch_2.nearest_rgb("#2D5A1B"), "#336633")
        self.assertEqual(ch_2.nearest_rgb("#00FF66"), "#00FF66")


if __name__ == "__main__":
    unittest.main()
